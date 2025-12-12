import React, { Component } from 'react'

export default class Results extends Component {
    constructor(props) {
        super(props);
        this.state = {
            copiedId: null
        };
    }

    copyToClipboard = (data) => {
        // Format data as "key: value" pairs
        const text = Object.entries(data)
            .map(([key, value]) => `${key}: ${value}`)
            .join(',\n');
        
        navigator.clipboard.writeText(text).then(() => {
            this.setState({ copiedId: data.id });
            // Reset after 2 seconds
            setTimeout(() => {
                this.setState({ copiedId: null });
            }, 2000);
        });
    }

    dataBlock(data) {
        const isCopied = this.state.copiedId === data.id;
        
        return (
            <div className="p-4 bg-white rounded-lg shadow-md mb-4 relative group cursor-pointer hover:shadow-lg transition-shadow"
                 onClick={() => this.copyToClipboard(data)}>
                <p className="text-gray-800"><span className="font-semibold">id:</span> {data.id}</p>
                <p className="text-gray-800"><span className="font-semibold">name:</span> {data.name}</p>
                <p className="text-gray-800"><span className="font-semibold">value:</span> {data.value}</p>
                
                {/* Copy button - appears on hover */}
                <button
                    className="absolute top-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity bg-blue-500 text-white px-3 py-1 rounded text-sm hover:bg-blue-600"
                    onClick={(e) => {
                        e.stopPropagation();
                        this.copyToClipboard(data);
                    }}
                >
                    {isCopied ? '✓ Copied!' : 'Copy'}
                </button>
            </div>
        )
    }

    render() {
        const { data = [] } = this.props; // Get data from props
        
        return (
            <div className="h-full bg-gray-200 rounded-lg shadow-md overflow-hidden flex flex-col">
                <div className="flex-1 overflow-y-auto px-8 p-6">
                    {data.length === 0 ? (
                        <div className="flex items-center justify-center h-full">
                            <div className="text-center">
                                <p className="text-gray-500 text-xl font-semibold">Information not found</p>
                                <p className="text-gray-400 mt-2">No results match your search</p>
                            </div>
                        </div>
                    ) : (
                        data.map((item, index) => (
                            <div key={item.id || index}>
                                {this.dataBlock(item)}
                            </div>
                        ))
                    )}
                </div>
            </div>
        )
    }
}
