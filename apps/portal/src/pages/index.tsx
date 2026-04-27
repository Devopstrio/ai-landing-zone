import React, { useState } from 'react';

// Devopstrio AI-LZ: Self-Service Provisioning Portal
// Stack: Next.js 14 + Tailwind CSS + TypeScript

const ProvisioningPortal = () => {
    const [selectedTemplate, setSelectedTemplate] = useState('GenAI Sandbox');

    return (
        <div className="min-h-screen bg-[#020617] text-slate-100 selection:bg-indigo-500/30">
            {/* Header / Nav */}
            <nav className="border-b border-white/5 bg-slate-900/40 backdrop-blur-md sticky top-0 z-50">
                <div className="max-w-7xl mx-auto px-8 h-20 flex items-center justify-between">
                    <div className="flex items-center gap-3">
                        <div className="w-9 h-9 bg-indigo-600 rounded-lg flex items-center justify-center font-black">LZ</div>
                        <span className="font-bold text-lg">AI Landing Zone <span className="text-slate-500 font-normal">v3.5</span></span>
                    </div>
                    <div className="flex gap-4 items-center">
                        <div className="px-3 py-1 bg-emerald-500/10 text-emerald-400 text-[10px] font-black uppercase rounded-full border border-emerald-500/20">Operational</div>
                        <div className="w-10 h-10 rounded-full bg-slate-800 border border-white/10"></div>
                    </div>
                </div>
            </nav>

            <main className="max-w-7xl mx-auto px-8 py-12">
                <header className="mb-12">
                    <h1 className="text-4xl font-black tracking-tight">Provision Isolated AI Workspace</h1>
                    <p className="text-slate-400 mt-2">Request an enterprise-hardened hub-spoke environment for your project.</p>
                </header>

                <div className="grid grid-cols-1 lg:grid-cols-12 gap-10">

                    {/* Marketplace / Catalog */}
                    <div className="lg:col-span-8 flex flex-col gap-6">
                        <h3 className="text-sm font-black uppercase tracking-widest text-slate-500 mb-2">Available Templates</h3>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                            {[
                                { name: 'GenAI Sandbox', id: 'S-01', desc: 'Secure OpenAI Instance + Private Link' },
                                { name: 'RAG Platform', id: 'M-02', desc: 'AKS Cluster + Vector DB + Storage' },
                                { name: 'Data Science Hub', id: 'M-03', desc: 'Dedicated Spoke + Notebook Runtimes' },
                                { name: 'LLM Inference', id: 'L-04', desc: 'Multi-GPU Cluster + API FrontDoor' }
                            ].map((item, idx) => (
                                <div
                                    key={idx}
                                    onClick={() => setSelectedTemplate(item.name)}
                                    className={`p-6 rounded-3xl border transition-all cursor-pointer ${selectedTemplate === item.name ? 'bg-indigo-600 border-indigo-400' : 'bg-slate-900 border-white/5 hover:border-white/20'}`}
                                >
                                    <div className="flex justify-between items-start mb-4">
                                        <div className="w-10 h-10 bg-white/10 rounded-xl flex items-center justify-center font-bold text-xs">{item.id}</div>
                                        {selectedTemplate === item.name && <div className="text-[10px] uppercase font-black bg-white text-indigo-600 px-2 py-0.5 rounded-full">Selected</div>}
                                    </div>
                                    <h4 className="font-bold text-lg">{item.name}</h4>
                                    <p className={`text-sm mt-1 ${selectedTemplate === item.name ? 'text-indigo-200' : 'text-slate-500'}`}>{item.desc}</p>
                                </div>
                            ))}
                        </div>
                    </div>

                    {/* Request Form Sidebar */}
                    <div className="lg:col-span-4 self-start sticky top-32">
                        <div className="bg-white text-slate-900 p-8 rounded-[32px] shadow-2xl">
                            <h3 className="font-black text-xl mb-6">Delivery Configuration</h3>
                            <div className="space-y-5">
                                <div>
                                    <label className="text-[10px] font-black uppercase text-slate-400">Team / Business Unit</label>
                                    <input type="text" className="w-full mt-1 px-4 py-3 bg-slate-100 rounded-xl border-none text-sm focus:ring-2 focus:ring-indigo-500" placeholder="Engineering-Alpha" />
                                </div>
                                <div>
                                    <label className="text-[10px] font-black uppercase text-slate-400">Target Region</label>
                                    <select className="w-full mt-1 px-4 py-3 bg-slate-100 rounded-xl border-none text-sm focus:ring-2 focus:ring-indigo-500">
                                        <option>UK South (London)</option>
                                        <option>UK West (Cardiff)</option>
                                        <option>West Europe (Amsterdam)</option>
                                    </select>
                                </div>
                                <div>
                                    <label className="text-[10px] font-black uppercase text-slate-400">Cost Center / Budget Code</label>
                                    <input type="text" className="w-full mt-1 px-4 py-3 bg-slate-100 rounded-xl border-none text-sm focus:ring-2 focus:ring-indigo-500" placeholder="BC-2026-AI" />
                                </div>
                            </div>

                            <div className="mt-8 pt-8 border-t border-slate-100">
                                <div className="flex justify-between mb-2">
                                    <span className="text-slate-400 text-sm">Estimated Monthly Cost</span>
                                    <span className="font-bold text-slate-900">$240.00</span>
                                </div>
                                <button className="w-full py-4 mt-4 bg-indigo-600 text-white rounded-2xl font-black text-sm uppercase tracking-widest shadow-xl shadow-indigo-600/30 hover:bg-slate-900 transition-all">
                                    Request Provisioning
                                </button>
                            </div>
                        </div>

                        <div className="mt-8 p-6 bg-slate-900/40 rounded-3xl border border-white/5 text-[11px] text-slate-500 leading-relaxed italic text-center">
                            Compliance Gate: All deployments are restricted to Private Link endpoints and regional residency is enforced.
                        </div>
                    </div>
                </div>
            </main>
        </div>
    );
};

export default ProvisioningPortal;
