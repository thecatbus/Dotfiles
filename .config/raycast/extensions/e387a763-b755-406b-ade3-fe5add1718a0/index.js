"use strict";require("./__raycast_check_for_updates");var jn=Object.create;var W=Object.defineProperty;var Un=Object.getOwnPropertyDescriptor;var Hn=Object.getOwnPropertyNames;var Dn=Object.getPrototypeOf,Wn=Object.prototype.hasOwnProperty;var d=(e,t)=>()=>(t||e((t={exports:{}}).exports,t),t.exports),Xn=(e,t)=>{for(var n in t)W(e,n,{get:t[n],enumerable:!0})},Me=(e,t,n,r)=>{if(t&&typeof t=="object"||typeof t=="function")for(let o of Hn(t))!Wn.call(e,o)&&o!==n&&W(e,o,{get:()=>t[o],enumerable:!(r=Un(t,o))||r.enumerable});return e};var b=(e,t,n)=>(n=e!=null?jn(Dn(e)):{},Me(t||!e||!e.__esModule?W(n,"default",{value:e,enumerable:!0}):n,e)),zn=e=>Me(W({},"__esModule",{value:!0}),e);var Ke=d((ti,ze)=>{ze.exports=Xe;Xe.sync=Vn;var De=require("fs");function Kn(e,t){var n=t.pathExt!==void 0?t.pathExt:process.env.PATHEXT;if(!n||(n=n.split(";"),n.indexOf("")!==-1))return!0;for(var r=0;r<n.length;r++){var o=n[r].toLowerCase();if(o&&e.substr(-o.length).toLowerCase()===o)return!0}return!1}function We(e,t,n){return!e.isSymbolicLink()&&!e.isFile()?!1:Kn(t,n)}function Xe(e,t,n){De.stat(e,function(r,o){n(r,r?!1:We(o,e,t))})}function Vn(e,t){return We(De.statSync(e),e,t)}});var Je=d((ni,Qe)=>{Qe.exports=Ze;Ze.sync=Zn;var Ve=require("fs");function Ze(e,t,n){Ve.stat(e,function(r,o){n(r,r?!1:Ye(o,t))})}function Zn(e,t){return Ye(Ve.statSync(e),t)}function Ye(e,t){return e.isFile()&&Yn(e,t)}function Yn(e,t){var n=e.mode,r=e.uid,o=e.gid,i=t.uid!==void 0?t.uid:process.getuid&&process.getuid(),s=t.gid!==void 0?t.gid:process.getgid&&process.getgid(),a=parseInt("100",8),l=parseInt("010",8),u=parseInt("001",8),p=a|l,g=n&u||n&l&&o===s||n&a&&r===i||n&p&&i===0;return g}});var tt=d((oi,et)=>{var ri=require("fs"),z;process.platform==="win32"||global.TESTING_WINDOWS?z=Ke():z=Je();et.exports=ue;ue.sync=Qn;function ue(e,t,n){if(typeof t=="function"&&(n=t,t={}),!n){if(typeof Promise!="function")throw new TypeError("callback not provided");return new Promise(function(r,o){ue(e,t||{},function(i,s){i?o(i):r(s)})})}z(e,t||{},function(r,o){r&&(r.code==="EACCES"||t&&t.ignoreErrors)&&(r=null,o=!1),n(r,o)})}function Qn(e,t){try{return z.sync(e,t||{})}catch(n){if(t&&t.ignoreErrors||n.code==="EACCES")return!1;throw n}}});var ct=d((ii,at)=>{var A=process.platform==="win32"||process.env.OSTYPE==="cygwin"||process.env.OSTYPE==="msys",nt=require("path"),Jn=A?";":":",rt=tt(),ot=e=>Object.assign(new Error(`not found: ${e}`),{code:"ENOENT"}),it=(e,t)=>{let n=t.colon||Jn,r=e.match(/\//)||A&&e.match(/\\/)?[""]:[...A?[process.cwd()]:[],...(t.path||process.env.PATH||"").split(n)],o=A?t.pathExt||process.env.PATHEXT||".EXE;.CMD;.BAT;.COM":"",i=A?o.split(n):[""];return A&&e.indexOf(".")!==-1&&i[0]!==""&&i.unshift(""),{pathEnv:r,pathExt:i,pathExtExe:o}},st=(e,t,n)=>{typeof t=="function"&&(n=t,t={}),t||(t={});let{pathEnv:r,pathExt:o,pathExtExe:i}=it(e,t),s=[],a=u=>new Promise((p,g)=>{if(u===r.length)return t.all&&s.length?p(s):g(ot(e));let w=r[u],S=/^".*"$/.test(w)?w.slice(1,-1):w,h=nt.join(S,e),f=!S&&/^\.[\\\/]/.test(e)?e.slice(0,2)+h:h;p(l(f,u,0))}),l=(u,p,g)=>new Promise((w,S)=>{if(g===o.length)return w(a(p+1));let h=o[g];rt(u+h,{pathExt:i},(f,E)=>{if(!f&&E)if(t.all)s.push(u+h);else return w(u+h);return w(l(u,p,g+1))})});return n?a(0).then(u=>n(null,u),n):a(0)},er=(e,t)=>{t=t||{};let{pathEnv:n,pathExt:r,pathExtExe:o}=it(e,t),i=[];for(let s=0;s<n.length;s++){let a=n[s],l=/^".*"$/.test(a)?a.slice(1,-1):a,u=nt.join(l,e),p=!l&&/^\.[\\\/]/.test(e)?e.slice(0,2)+u:u;for(let g=0;g<r.length;g++){let w=p+r[g];try{if(rt.sync(w,{pathExt:o}))if(t.all)i.push(w);else return w}catch{}}}if(t.all&&i.length)return i;if(t.nothrow)return null;throw ot(e)};at.exports=st;st.sync=er});var fe=d((si,de)=>{"use strict";var lt=(e={})=>{let t=e.env||process.env;return(e.platform||process.platform)!=="win32"?"PATH":Object.keys(t).reverse().find(r=>r.toUpperCase()==="PATH")||"Path"};de.exports=lt;de.exports.default=lt});var pt=d((ai,ft)=>{"use strict";var ut=require("path"),tr=ct(),nr=fe();function dt(e,t){let n=e.options.env||process.env,r=process.cwd(),o=e.options.cwd!=null,i=o&&process.chdir!==void 0&&!process.chdir.disabled;if(i)try{process.chdir(e.options.cwd)}catch{}let s;try{s=tr.sync(e.command,{path:n[nr({env:n})],pathExt:t?ut.delimiter:void 0})}catch{}finally{i&&process.chdir(r)}return s&&(s=ut.resolve(o?e.options.cwd:"",s)),s}function rr(e){return dt(e)||dt(e,!0)}ft.exports=rr});var mt=d((ci,me)=>{"use strict";var pe=/([()\][%!^"`<>&|;, *?])/g;function or(e){return e=e.replace(pe,"^$1"),e}function ir(e,t){return e=`${e}`,e=e.replace(/(\\*)"/g,'$1$1\\"'),e=e.replace(/(\\*)$/,"$1$1"),e=`"${e}"`,e=e.replace(pe,"^$1"),t&&(e=e.replace(pe,"^$1")),e}me.exports.command=or;me.exports.argument=ir});var wt=d((li,ht)=>{"use strict";ht.exports=/^#!(.*)/});var gt=d((ui,yt)=>{"use strict";var sr=wt();yt.exports=(e="")=>{let t=e.match(sr);if(!t)return null;let[n,r]=t[0].replace(/#! ?/,"").split(" "),o=n.split("/").pop();return o==="env"?r:r?`${o} ${r}`:o}});var xt=d((di,St)=>{"use strict";var he=require("fs"),ar=gt();function cr(e){let n=Buffer.alloc(150),r;try{r=he.openSync(e,"r"),he.readSync(r,n,0,150,0),he.closeSync(r)}catch{}return ar(n.toString())}St.exports=cr});var _t=d((fi,vt)=>{"use strict";var lr=require("path"),bt=pt(),Et=mt(),ur=xt(),dr=process.platform==="win32",fr=/\.(?:com|exe)$/i,pr=/node_modules[\\/].bin[\\/][^\\/]+\.cmd$/i;function mr(e){e.file=bt(e);let t=e.file&&ur(e.file);return t?(e.args.unshift(e.file),e.command=t,bt(e)):e.file}function hr(e){if(!dr)return e;let t=mr(e),n=!fr.test(t);if(e.options.forceShell||n){let r=pr.test(t);e.command=lr.normalize(e.command),e.command=Et.command(e.command),e.args=e.args.map(i=>Et.argument(i,r));let o=[e.command].concat(e.args).join(" ");e.args=["/d","/s","/c",`"${o}"`],e.command=process.env.comspec||"cmd.exe",e.options.windowsVerbatimArguments=!0}return e}function wr(e,t,n){t&&!Array.isArray(t)&&(n=t,t=null),t=t?t.slice(0):[],n=Object.assign({},n);let r={command:e,args:t,options:n,file:void 0,original:{command:e,args:t}};return n.shell?r:hr(r)}vt.exports=wr});var Pt=d((pi,Tt)=>{"use strict";var we=process.platform==="win32";function ye(e,t){return Object.assign(new Error(`${t} ${e.command} ENOENT`),{code:"ENOENT",errno:"ENOENT",syscall:`${t} ${e.command}`,path:e.command,spawnargs:e.args})}function yr(e,t){if(!we)return;let n=e.emit;e.emit=function(r,o){if(r==="exit"){let i=It(o,t,"spawn");if(i)return n.call(e,"error",i)}return n.apply(e,arguments)}}function It(e,t){return we&&e===1&&!t.file?ye(t.original,"spawn"):null}function gr(e,t){return we&&e===1&&!t.file?ye(t.original,"spawnSync"):null}Tt.exports={hookChildProcess:yr,verifyENOENT:It,verifyENOENTSync:gr,notFoundError:ye}});var Gt=d((mi,G)=>{"use strict";var Ct=require("child_process"),ge=_t(),Se=Pt();function At(e,t,n){let r=ge(e,t,n),o=Ct.spawn(r.command,r.args,r.options);return Se.hookChildProcess(o,r),o}function Sr(e,t,n){let r=ge(e,t,n),o=Ct.spawnSync(r.command,r.args,r.options);return o.error=o.error||Se.verifyENOENTSync(o.status,r),o}G.exports=At;G.exports.spawn=At;G.exports.sync=Sr;G.exports._parse=ge;G.exports._enoent=Se});var Lt=d((hi,Rt)=>{"use strict";Rt.exports=e=>{let t=typeof e=="string"?`
`:10,n=typeof e=="string"?"\r":13;return e[e.length-1]===t&&(e=e.slice(0,e.length-1)),e[e.length-1]===n&&(e=e.slice(0,e.length-1)),e}});var Nt=d((wi,B)=>{"use strict";var M=require("path"),kt=fe(),Ot=e=>{e={cwd:process.cwd(),path:process.env[kt()],execPath:process.execPath,...e};let t,n=M.resolve(e.cwd),r=[];for(;t!==n;)r.push(M.join(n,"node_modules/.bin")),t=n,n=M.resolve(n,"..");let o=M.resolve(e.cwd,e.execPath,"..");return r.push(o),r.concat(e.path).join(M.delimiter)};B.exports=Ot;B.exports.default=Ot;B.exports.env=e=>{e={env:process.env,...e};let t={...e.env},n=kt({env:t});return e.path=t[n],t[n]=B.exports(e),t}});var $t=d((yi,xe)=>{"use strict";var qt=(e,t)=>{for(let n of Reflect.ownKeys(t))Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n));return e};xe.exports=qt;xe.exports.default=qt});var Bt=d((gi,V)=>{"use strict";var xr=$t(),K=new WeakMap,Mt=(e,t={})=>{if(typeof e!="function")throw new TypeError("Expected a function");let n,r=0,o=e.displayName||e.name||"<anonymous>",i=function(...s){if(K.set(i,++r),r===1)n=e.apply(this,s),e=null;else if(t.throw===!0)throw new Error(`Function \`${o}\` can only be called once`);return n};return xr(i,e),K.set(i,r),i};V.exports=Mt;V.exports.default=Mt;V.exports.callCount=e=>{if(!K.has(e))throw new Error(`The given function \`${e.name}\` is not wrapped by the \`onetime\` package`);return K.get(e)}});var Ft=d(Z=>{"use strict";Object.defineProperty(Z,"__esModule",{value:!0});Z.SIGNALS=void 0;var br=[{name:"SIGHUP",number:1,action:"terminate",description:"Terminal closed",standard:"posix"},{name:"SIGINT",number:2,action:"terminate",description:"User interruption with CTRL-C",standard:"ansi"},{name:"SIGQUIT",number:3,action:"core",description:"User interruption with CTRL-\\",standard:"posix"},{name:"SIGILL",number:4,action:"core",description:"Invalid machine instruction",standard:"ansi"},{name:"SIGTRAP",number:5,action:"core",description:"Debugger breakpoint",standard:"posix"},{name:"SIGABRT",number:6,action:"core",description:"Aborted",standard:"ansi"},{name:"SIGIOT",number:6,action:"core",description:"Aborted",standard:"bsd"},{name:"SIGBUS",number:7,action:"core",description:"Bus error due to misaligned, non-existing address or paging error",standard:"bsd"},{name:"SIGEMT",number:7,action:"terminate",description:"Command should be emulated but is not implemented",standard:"other"},{name:"SIGFPE",number:8,action:"core",description:"Floating point arithmetic error",standard:"ansi"},{name:"SIGKILL",number:9,action:"terminate",description:"Forced termination",standard:"posix",forced:!0},{name:"SIGUSR1",number:10,action:"terminate",description:"Application-specific signal",standard:"posix"},{name:"SIGSEGV",number:11,action:"core",description:"Segmentation fault",standard:"ansi"},{name:"SIGUSR2",number:12,action:"terminate",description:"Application-specific signal",standard:"posix"},{name:"SIGPIPE",number:13,action:"terminate",description:"Broken pipe or socket",standard:"posix"},{name:"SIGALRM",number:14,action:"terminate",description:"Timeout or timer",standard:"posix"},{name:"SIGTERM",number:15,action:"terminate",description:"Termination",standard:"ansi"},{name:"SIGSTKFLT",number:16,action:"terminate",description:"Stack is empty or overflowed",standard:"other"},{name:"SIGCHLD",number:17,action:"ignore",description:"Child process terminated, paused or unpaused",standard:"posix"},{name:"SIGCLD",number:17,action:"ignore",description:"Child process terminated, paused or unpaused",standard:"other"},{name:"SIGCONT",number:18,action:"unpause",description:"Unpaused",standard:"posix",forced:!0},{name:"SIGSTOP",number:19,action:"pause",description:"Paused",standard:"posix",forced:!0},{name:"SIGTSTP",number:20,action:"pause",description:'Paused using CTRL-Z or "suspend"',standard:"posix"},{name:"SIGTTIN",number:21,action:"pause",description:"Background process cannot read terminal input",standard:"posix"},{name:"SIGBREAK",number:21,action:"terminate",description:"User interruption with CTRL-BREAK",standard:"other"},{name:"SIGTTOU",number:22,action:"pause",description:"Background process cannot write to terminal output",standard:"posix"},{name:"SIGURG",number:23,action:"ignore",description:"Socket received out-of-band data",standard:"bsd"},{name:"SIGXCPU",number:24,action:"core",description:"Process timed out",standard:"bsd"},{name:"SIGXFSZ",number:25,action:"core",description:"File too big",standard:"bsd"},{name:"SIGVTALRM",number:26,action:"terminate",description:"Timeout or timer",standard:"bsd"},{name:"SIGPROF",number:27,action:"terminate",description:"Timeout or timer",standard:"bsd"},{name:"SIGWINCH",number:28,action:"ignore",description:"Terminal window size changed",standard:"bsd"},{name:"SIGIO",number:29,action:"terminate",description:"I/O is available",standard:"other"},{name:"SIGPOLL",number:29,action:"terminate",description:"Watched event",standard:"other"},{name:"SIGINFO",number:29,action:"ignore",description:"Request for process information",standard:"other"},{name:"SIGPWR",number:30,action:"terminate",description:"Device running out of power",standard:"systemv"},{name:"SIGSYS",number:31,action:"core",description:"Invalid system call",standard:"other"},{name:"SIGUNUSED",number:31,action:"terminate",description:"Invalid system call",standard:"other"}];Z.SIGNALS=br});var be=d(R=>{"use strict";Object.defineProperty(R,"__esModule",{value:!0});R.SIGRTMAX=R.getRealtimeSignals=void 0;var Er=function(){let e=Ut-jt+1;return Array.from({length:e},vr)};R.getRealtimeSignals=Er;var vr=function(e,t){return{name:`SIGRT${t+1}`,number:jt+t,action:"terminate",description:"Application-specific signal (realtime)",standard:"posix"}},jt=34,Ut=64;R.SIGRTMAX=Ut});var Ht=d(Y=>{"use strict";Object.defineProperty(Y,"__esModule",{value:!0});Y.getSignals=void 0;var _r=require("os"),Ir=Ft(),Tr=be(),Pr=function(){let e=(0,Tr.getRealtimeSignals)();return[...Ir.SIGNALS,...e].map(Cr)};Y.getSignals=Pr;var Cr=function({name:e,number:t,description:n,action:r,forced:o=!1,standard:i}){let{signals:{[e]:s}}=_r.constants,a=s!==void 0;return{name:e,number:a?s:t,description:n,supported:a,action:r,forced:o,standard:i}}});var Wt=d(L=>{"use strict";Object.defineProperty(L,"__esModule",{value:!0});L.signalsByNumber=L.signalsByName=void 0;var Ar=require("os"),Dt=Ht(),Gr=be(),Rr=function(){return(0,Dt.getSignals)().reduce(Lr,{})},Lr=function(e,{name:t,number:n,description:r,supported:o,action:i,forced:s,standard:a}){return{...e,[t]:{name:t,number:n,description:r,supported:o,action:i,forced:s,standard:a}}},kr=Rr();L.signalsByName=kr;var Or=function(){let e=(0,Dt.getSignals)(),t=Gr.SIGRTMAX+1,n=Array.from({length:t},(r,o)=>Nr(o,e));return Object.assign({},...n)},Nr=function(e,t){let n=qr(e,t);if(n===void 0)return{};let{name:r,description:o,supported:i,action:s,forced:a,standard:l}=n;return{[e]:{name:r,number:e,description:o,supported:i,action:s,forced:a,standard:l}}},qr=function(e,t){let n=t.find(({name:r})=>Ar.constants.signals[r]===e);return n!==void 0?n:t.find(r=>r.number===e)},$r=Or();L.signalsByNumber=$r});var zt=d((vi,Xt)=>{"use strict";var{signalsByName:Mr}=Wt(),Br=({timedOut:e,timeout:t,errorCode:n,signal:r,signalDescription:o,exitCode:i,isCanceled:s})=>e?`timed out after ${t} milliseconds`:s?"was canceled":n!==void 0?`failed with ${n}`:r!==void 0?`was killed with ${r} (${o})`:i!==void 0?`failed with exit code ${i}`:"failed",Fr=({stdout:e,stderr:t,all:n,error:r,signal:o,exitCode:i,command:s,escapedCommand:a,timedOut:l,isCanceled:u,killed:p,parsed:{options:{timeout:g}}})=>{i=i===null?void 0:i,o=o===null?void 0:o;let w=o===void 0?void 0:Mr[o].description,S=r&&r.code,f=`Command ${Br({timedOut:l,timeout:g,errorCode:S,signal:o,signalDescription:w,exitCode:i,isCanceled:u})}: ${s}`,E=Object.prototype.toString.call(r)==="[object Error]",H=E?`${f}
${r.message}`:f,D=[H,t,e].filter(Boolean).join(`
`);return E?(r.originalMessage=r.message,r.message=D):r=new Error(D),r.shortMessage=H,r.command=s,r.escapedCommand=a,r.exitCode=i,r.signal=o,r.signalDescription=w,r.stdout=e,r.stderr=t,n!==void 0&&(r.all=n),"bufferedData"in r&&delete r.bufferedData,r.failed=!0,r.timedOut=!!l,r.isCanceled=u,r.killed=p&&!l,r};Xt.exports=Fr});var Vt=d((_i,Ee)=>{"use strict";var Q=["stdin","stdout","stderr"],jr=e=>Q.some(t=>e[t]!==void 0),Kt=e=>{if(!e)return;let{stdio:t}=e;if(t===void 0)return Q.map(r=>e[r]);if(jr(e))throw new Error(`It's not possible to provide \`stdio\` in combination with one of ${Q.map(r=>`\`${r}\``).join(", ")}`);if(typeof t=="string")return t;if(!Array.isArray(t))throw new TypeError(`Expected \`stdio\` to be of type \`string\` or \`Array\`, got \`${typeof t}\``);let n=Math.max(t.length,Q.length);return Array.from({length:n},(r,o)=>t[o])};Ee.exports=Kt;Ee.exports.node=e=>{let t=Kt(e);return t==="ipc"?"ipc":t===void 0||typeof t=="string"?[t,t,t,"ipc"]:t.includes("ipc")?t:[...t,"ipc"]}});var Zt=d((Ii,J)=>{J.exports=["SIGABRT","SIGALRM","SIGHUP","SIGINT","SIGTERM"];process.platform!=="win32"&&J.exports.push("SIGVTALRM","SIGXCPU","SIGXFSZ","SIGUSR2","SIGTRAP","SIGSYS","SIGQUIT","SIGIOT");process.platform==="linux"&&J.exports.push("SIGIO","SIGPOLL","SIGPWR","SIGSTKFLT","SIGUNUSED")});var tn=d((Ti,N)=>{var m=global.process,I=function(e){return e&&typeof e=="object"&&typeof e.removeListener=="function"&&typeof e.emit=="function"&&typeof e.reallyExit=="function"&&typeof e.listeners=="function"&&typeof e.kill=="function"&&typeof e.pid=="number"&&typeof e.on=="function"};I(m)?(Yt=require("assert"),k=Zt(),Qt=/^win/i.test(m.platform),F=require("events"),typeof F!="function"&&(F=F.EventEmitter),m.__signal_exit_emitter__?y=m.__signal_exit_emitter__:(y=m.__signal_exit_emitter__=new F,y.count=0,y.emitted={}),y.infinite||(y.setMaxListeners(1/0),y.infinite=!0),N.exports=function(e,t){if(!I(global.process))return function(){};Yt.equal(typeof e,"function","a callback must be provided for exit handler"),O===!1&&ve();var n="exit";t&&t.alwaysLast&&(n="afterexit");var r=function(){y.removeListener(n,e),y.listeners("exit").length===0&&y.listeners("afterexit").length===0&&ee()};return y.on(n,e),r},ee=function(){!O||!I(global.process)||(O=!1,k.forEach(function(t){try{m.removeListener(t,te[t])}catch{}}),m.emit=ne,m.reallyExit=_e,y.count-=1)},N.exports.unload=ee,T=function(t,n,r){y.emitted[t]||(y.emitted[t]=!0,y.emit(t,n,r))},te={},k.forEach(function(e){te[e]=function(){if(I(global.process)){var n=m.listeners(e);n.length===y.count&&(ee(),T("exit",null,e),T("afterexit",null,e),Qt&&e==="SIGHUP"&&(e="SIGINT"),m.kill(m.pid,e))}}}),N.exports.signals=function(){return k},O=!1,ve=function(){O||!I(global.process)||(O=!0,y.count+=1,k=k.filter(function(t){try{return m.on(t,te[t]),!0}catch{return!1}}),m.emit=en,m.reallyExit=Jt)},N.exports.load=ve,_e=m.reallyExit,Jt=function(t){I(global.process)&&(m.exitCode=t||0,T("exit",m.exitCode,null),T("afterexit",m.exitCode,null),_e.call(m,m.exitCode))},ne=m.emit,en=function(t,n){if(t==="exit"&&I(global.process)){n!==void 0&&(m.exitCode=n);var r=ne.apply(this,arguments);return T("exit",m.exitCode,null),T("afterexit",m.exitCode,null),r}else return ne.apply(this,arguments)}):N.exports=function(){return function(){}};var Yt,k,Qt,F,y,ee,T,te,O,ve,_e,Jt,ne,en});var rn=d((Pi,nn)=>{"use strict";var Ur=require("os"),Hr=tn(),Dr=1e3*5,Wr=(e,t="SIGTERM",n={})=>{let r=e(t);return Xr(e,t,n,r),r},Xr=(e,t,n,r)=>{if(!zr(t,n,r))return;let o=Vr(n),i=setTimeout(()=>{e("SIGKILL")},o);i.unref&&i.unref()},zr=(e,{forceKillAfterTimeout:t},n)=>Kr(e)&&t!==!1&&n,Kr=e=>e===Ur.constants.signals.SIGTERM||typeof e=="string"&&e.toUpperCase()==="SIGTERM",Vr=({forceKillAfterTimeout:e=!0})=>{if(e===!0)return Dr;if(!Number.isFinite(e)||e<0)throw new TypeError(`Expected the \`forceKillAfterTimeout\` option to be a non-negative integer, got \`${e}\` (${typeof e})`);return e},Zr=(e,t)=>{e.kill()&&(t.isCanceled=!0)},Yr=(e,t,n)=>{e.kill(t),n(Object.assign(new Error("Timed out"),{timedOut:!0,signal:t}))},Qr=(e,{timeout:t,killSignal:n="SIGTERM"},r)=>{if(t===0||t===void 0)return r;let o,i=new Promise((a,l)=>{o=setTimeout(()=>{Yr(e,n,l)},t)}),s=r.finally(()=>{clearTimeout(o)});return Promise.race([i,s])},Jr=({timeout:e})=>{if(e!==void 0&&(!Number.isFinite(e)||e<0))throw new TypeError(`Expected the \`timeout\` option to be a non-negative integer, got \`${e}\` (${typeof e})`)},eo=async(e,{cleanup:t,detached:n},r)=>{if(!t||n)return r;let o=Hr(()=>{e.kill()});return r.finally(()=>{o()})};nn.exports={spawnedKill:Wr,spawnedCancel:Zr,setupTimeout:Qr,validateTimeout:Jr,setExitHandler:eo}});var sn=d((Ci,on)=>{"use strict";var v=e=>e!==null&&typeof e=="object"&&typeof e.pipe=="function";v.writable=e=>v(e)&&e.writable!==!1&&typeof e._write=="function"&&typeof e._writableState=="object";v.readable=e=>v(e)&&e.readable!==!1&&typeof e._read=="function"&&typeof e._readableState=="object";v.duplex=e=>v.writable(e)&&v.readable(e);v.transform=e=>v.duplex(e)&&typeof e._transform=="function";on.exports=v});var cn=d((Ai,an)=>{"use strict";var{PassThrough:to}=require("stream");an.exports=e=>{e={...e};let{array:t}=e,{encoding:n}=e,r=n==="buffer",o=!1;t?o=!(n||r):n=n||"utf8",r&&(n=null);let i=new to({objectMode:o});n&&i.setEncoding(n);let s=0,a=[];return i.on("data",l=>{a.push(l),o?s=a.length:s+=l.length}),i.getBufferedValue=()=>t?a:r?Buffer.concat(a,s):a.join(""),i.getBufferedLength=()=>s,i}});var ln=d((Gi,j)=>{"use strict";var{constants:no}=require("buffer"),ro=require("stream"),{promisify:oo}=require("util"),io=cn(),so=oo(ro.pipeline),re=class extends Error{constructor(){super("maxBuffer exceeded"),this.name="MaxBufferError"}};async function Ie(e,t){if(!e)throw new Error("Expected a stream");t={maxBuffer:1/0,...t};let{maxBuffer:n}=t,r=io(t);return await new Promise((o,i)=>{let s=a=>{a&&r.getBufferedLength()<=no.MAX_LENGTH&&(a.bufferedData=r.getBufferedValue()),i(a)};(async()=>{try{await so(e,r),o()}catch(a){s(a)}})(),r.on("data",()=>{r.getBufferedLength()>n&&s(new re)})}),r.getBufferedValue()}j.exports=Ie;j.exports.buffer=(e,t)=>Ie(e,{...t,encoding:"buffer"});j.exports.array=(e,t)=>Ie(e,{...t,array:!0});j.exports.MaxBufferError=re});var dn=d((Ri,un)=>{"use strict";var{PassThrough:ao}=require("stream");un.exports=function(){var e=[],t=new ao({objectMode:!0});return t.setMaxListeners(0),t.add=n,t.isEmpty=r,t.on("unpipe",o),Array.prototype.slice.call(arguments).forEach(n),t;function n(i){return Array.isArray(i)?(i.forEach(n),this):(e.push(i),i.once("end",o.bind(null,i)),i.once("error",t.emit.bind(t,"error")),i.pipe(t,{end:!1}),this)}function r(){return e.length==0}function o(i){e=e.filter(function(s){return s!==i}),!e.length&&t.readable&&t.end()}}});var hn=d((Li,mn)=>{"use strict";var pn=sn(),fn=ln(),co=dn(),lo=(e,t)=>{t===void 0||e.stdin===void 0||(pn(t)?t.pipe(e.stdin):e.stdin.end(t))},uo=(e,{all:t})=>{if(!t||!e.stdout&&!e.stderr)return;let n=co();return e.stdout&&n.add(e.stdout),e.stderr&&n.add(e.stderr),n},Te=async(e,t)=>{if(e){e.destroy();try{return await t}catch(n){return n.bufferedData}}},Pe=(e,{encoding:t,buffer:n,maxBuffer:r})=>{if(!(!e||!n))return t?fn(e,{encoding:t,maxBuffer:r}):fn.buffer(e,{maxBuffer:r})},fo=async({stdout:e,stderr:t,all:n},{encoding:r,buffer:o,maxBuffer:i},s)=>{let a=Pe(e,{encoding:r,buffer:o,maxBuffer:i}),l=Pe(t,{encoding:r,buffer:o,maxBuffer:i}),u=Pe(n,{encoding:r,buffer:o,maxBuffer:i*2});try{return await Promise.all([s,a,l,u])}catch(p){return Promise.all([{error:p,signal:p.signal,timedOut:p.timedOut},Te(e,a),Te(t,l),Te(n,u)])}},po=({input:e})=>{if(pn(e))throw new TypeError("The `input` option cannot be a stream in sync mode")};mn.exports={handleInput:lo,makeAllStream:uo,getSpawnedResult:fo,validateInputSync:po}});var yn=d((ki,wn)=>{"use strict";var mo=(async()=>{})().constructor.prototype,ho=["then","catch","finally"].map(e=>[e,Reflect.getOwnPropertyDescriptor(mo,e)]),wo=(e,t)=>{for(let[n,r]of ho){let o=typeof t=="function"?(...i)=>Reflect.apply(r.value,t(),i):r.value.bind(t);Reflect.defineProperty(e,n,{...r,value:o})}return e},yo=e=>new Promise((t,n)=>{e.on("exit",(r,o)=>{t({exitCode:r,signal:o})}),e.on("error",r=>{n(r)}),e.stdin&&e.stdin.on("error",r=>{n(r)})});wn.exports={mergePromise:wo,getSpawnedPromise:yo}});var xn=d((Oi,Sn)=>{"use strict";var gn=(e,t=[])=>Array.isArray(t)?[e,...t]:[e],go=/^[\w.-]+$/,So=/"/g,xo=e=>typeof e!="string"||go.test(e)?e:`"${e.replace(So,'\\"')}"`,bo=(e,t)=>gn(e,t).join(" "),Eo=(e,t)=>gn(e,t).map(n=>xo(n)).join(" "),vo=/ +/g,_o=e=>{let t=[];for(let n of e.trim().split(vo)){let r=t[t.length-1];r&&r.endsWith("\\")?t[t.length-1]=`${r.slice(0,-1)} ${n}`:t.push(n)}return t};Sn.exports={joinCommand:bo,getEscapedCommand:Eo,parseCommand:_o}});var Ae=d((Ni,q)=>{"use strict";var Io=require("path"),Ce=require("child_process"),To=Gt(),Po=Lt(),Co=Nt(),Ao=Bt(),oe=zt(),En=Vt(),{spawnedKill:Go,spawnedCancel:Ro,setupTimeout:Lo,validateTimeout:ko,setExitHandler:Oo}=rn(),{handleInput:No,getSpawnedResult:qo,makeAllStream:$o,validateInputSync:Mo}=hn(),{mergePromise:bn,getSpawnedPromise:Bo}=yn(),{joinCommand:vn,parseCommand:_n,getEscapedCommand:In}=xn(),Fo=1e3*1e3*100,jo=({env:e,extendEnv:t,preferLocal:n,localDir:r,execPath:o})=>{let i=t?{...process.env,...e}:e;return n?Co.env({env:i,cwd:r,execPath:o}):i},Tn=(e,t,n={})=>{let r=To._parse(e,t,n);return e=r.command,t=r.args,n=r.options,n={maxBuffer:Fo,buffer:!0,stripFinalNewline:!0,extendEnv:!0,preferLocal:!1,localDir:n.cwd||process.cwd(),execPath:process.execPath,encoding:"utf8",reject:!0,cleanup:!0,all:!1,windowsHide:!0,...n},n.env=jo(n),n.stdio=En(n),process.platform==="win32"&&Io.basename(e,".exe")==="cmd"&&t.unshift("/q"),{file:e,args:t,options:n,parsed:r}},U=(e,t,n)=>typeof t!="string"&&!Buffer.isBuffer(t)?n===void 0?void 0:"":e.stripFinalNewline?Po(t):t,ie=(e,t,n)=>{let r=Tn(e,t,n),o=vn(e,t),i=In(e,t);ko(r.options);let s;try{s=Ce.spawn(r.file,r.args,r.options)}catch(S){let h=new Ce.ChildProcess,f=Promise.reject(oe({error:S,stdout:"",stderr:"",all:"",command:o,escapedCommand:i,parsed:r,timedOut:!1,isCanceled:!1,killed:!1}));return bn(h,f)}let a=Bo(s),l=Lo(s,r.options,a),u=Oo(s,r.options,l),p={isCanceled:!1};s.kill=Go.bind(null,s.kill.bind(s)),s.cancel=Ro.bind(null,s,p);let w=Ao(async()=>{let[{error:S,exitCode:h,signal:f,timedOut:E},H,D,Fn]=await qo(s,r.options,u),Oe=U(r.options,H),Ne=U(r.options,D),qe=U(r.options,Fn);if(S||h!==0||f!==null){let $e=oe({error:S,exitCode:h,signal:f,stdout:Oe,stderr:Ne,all:qe,command:o,escapedCommand:i,parsed:r,timedOut:E,isCanceled:p.isCanceled,killed:s.killed});if(!r.options.reject)return $e;throw $e}return{command:o,escapedCommand:i,exitCode:0,stdout:Oe,stderr:Ne,all:qe,failed:!1,timedOut:!1,isCanceled:!1,killed:!1}});return No(s,r.options.input),s.all=$o(s,r.options),bn(s,w)};q.exports=ie;q.exports.sync=(e,t,n)=>{let r=Tn(e,t,n),o=vn(e,t),i=In(e,t);Mo(r.options);let s;try{s=Ce.spawnSync(r.file,r.args,r.options)}catch(u){throw oe({error:u,stdout:"",stderr:"",all:"",command:o,escapedCommand:i,parsed:r,timedOut:!1,isCanceled:!1,killed:!1})}let a=U(r.options,s.stdout,s.error),l=U(r.options,s.stderr,s.error);if(s.error||s.status!==0||s.signal!==null){let u=oe({stdout:a,stderr:l,error:s.error,signal:s.signal,exitCode:s.status,command:o,escapedCommand:i,parsed:r,timedOut:s.error&&s.error.code==="ETIMEDOUT",isCanceled:!1,killed:s.signal!==null});if(!r.options.reject)return u;throw u}return{command:o,escapedCommand:i,exitCode:0,stdout:a,stderr:l,failed:!1,timedOut:!1,isCanceled:!1,killed:!1}};q.exports.command=(e,t)=>{let[n,...r]=_n(e);return ie(n,r,t)};q.exports.commandSync=(e,t)=>{let[n,...r]=_n(e);return ie.sync(n,r,t)};q.exports.node=(e,t,n={})=>{t&&!Array.isArray(t)&&typeof t=="object"&&(n=t,t=[]);let r=En.node(n),o=process.execArgv.filter(a=>!a.startsWith("--inspect")),{nodePath:i=process.execPath,nodeOptions:s=o}=n;return ie(i,[...s,e,...Array.isArray(t)?t:[]],{...n,stdin:void 0,stdout:void 0,stderr:void 0,stdio:r,shell:!1})}});var Qo={};Xn(Qo,{default:()=>Bn});module.exports=zn(Qo);var _=require("react"),c=require("@raycast/api");var je=b(require("os"),1),C=b(require("fs"),1),X=b(require("path"),1),Ue=b(require("child_process"),1);function Be(e){let t=/^: \d+:0;/;return e.trim().split(`
`).map(n=>t.test(n)?n.split(";").slice(1).join(";"):n)}function Fe({extraPaths:e=[]}={}){if(process.env.HISTFILE)return process.env.HISTFILE;let t=je.default.homedir(),n=new Set([X.default.join(t,".bash_history"),X.default.join(t,".zsh_history"),X.default.join(t,".history")]);for(let o of e)n.add(o);return(()=>{let o,i=0;for(let s of n)C.default.existsSync(s)&&C.default.statSync(s).size>i&&(i=C.default.statSync(s).size,o=s);return o})()}function He(e={}){if(process.platform==="win32"){let t=Fe(e);if(t)return Be(C.default.readFileSync(t,"utf8"));let{stdout:n}=Ue.default.spawnSync("doskey",["/history"],{encoding:"utf8"});return n.trim().split(`\r
`)}return Be(C.default.readFileSync(Fe(e),"utf8"))}var ae=b(require("node:process"),1),An=b(Ae(),1);function Ge({onlyFirst:e=!1}={}){let t=["[\\u001B\\u009B][[\\]()#;?]*(?:(?:(?:(?:;[-a-zA-Z\\d\\/#&.:=?%@~_]+)*|[a-zA-Z\\d]+(?:;[-a-zA-Z\\d\\/#&.:=?%@~_]*)*)?\\u0007)","(?:(?:\\d{1,4}(?:;\\d{0,4})*)?[\\dA-PR-TZcf-ntqry=><~]))"].join("|");return new RegExp(t,e?void 0:"g")}function Re(e){if(typeof e!="string")throw new TypeError(`Expected a \`string\`, got \`${typeof e}\``);return e.replace(Ge(),"")}var se=b(require("node:process"),1),Pn=require("node:os"),Uo=()=>{let{env:e}=se.default;if(se.default.platform==="win32")return e.COMSPEC||"cmd.exe";try{let{shell:t}=(0,Pn.userInfo)();if(t)return t}catch{}return se.default.platform==="darwin"?e.SHELL||"/bin/zsh":e.SHELL||"/bin/sh"},Ho=Uo(),Cn=Ho;var Do=["-ilc",'echo -n "_SHELL_ENV_DELIMITER_"; env; echo -n "_SHELL_ENV_DELIMITER_"; exit'],Wo={DISABLE_AUTO_UPDATE:"true"},Xo=e=>{e=e.split("_SHELL_ENV_DELIMITER_")[1];let t={};for(let n of Re(e).split(`
`).filter(r=>!!r)){let[r,...o]=n.split("=");t[r]=o.join("=")}return t};async function Gn(e){if(ae.default.platform==="win32")return ae.default.env;try{let{stdout:t}=await(0,An.default)(e||Cn,Do,{env:Wo});return Xo(t)}catch(t){if(e)throw t;return ae.default.env}}var Mn=require("child_process");var Rn=b(require("node:process"),1),Ln=b(Ae(),1);async function $(e){if(Rn.default.platform!=="darwin")throw new Error("macOS only");let{stdout:t}=await(0,Ln.default)("osascript",["-e",e]);return t}var zo=b(require("react"),1),Ko=require("react");var Vo=require("@raycast/api");var Le=require("@raycast/api"),P=require("react");function ke(e,t){let[n,r]=(0,P.useState)(!0),[o,i]=(0,P.useState)(t);(0,P.useEffect)(()=>{let a=!1;return(async()=>{let l=await Le.LocalStorage.getItem(e);typeof l=="string"&&(a||i(JSON.parse(l))),r(!1)})(),()=>{a=!0}},[]);let s=(0,P.useCallback)(a=>{i(l=>{let u=typeof a=="function"?a(l):a;return Le.LocalStorage.setItem(e,JSON.stringify(u)),u})},[]);return[o,s,n]}var le=b(require("fs")),x=require("react/jsx-runtime"),ce=null,Yo=async()=>{if(ce)return ce;let e=await Gn();return ce={env:e,cwd:e.HOME||`/Users/${process.env.USER}`,shell:e.SHELL},ce},kn=({cmd:e})=>{let[t,n]=(0,_.useState)(""),[r,o]=(0,_.useState)(!1);return(0,_.useEffect)(()=>{let i=!1,s=null;return(async()=>{let l=await Yo();s=(0,Mn.exec)(`$SHELL -i -c "${e}"`,l),s.stderr?.on("data",u=>{i||(n(u),(0,c.showToast)({style:c.Toast.Style.Failure,title:"Error executing command"}))}),s.stdout?.on("data",u=>{i||((0,c.showToast)({style:c.Toast.Style.Animated,title:"Executing command..."}),n(u))}),s.on("exit",()=>{(0,c.showToast)({style:c.Toast.Style.Success,title:"Command execution complete"}),o(!0)})})(),function(){i=!0,s!==null&&s.kill("SIGTERM")}},[e,n,o]),(0,x.jsx)(c.Detail,{markdown:"```\n$ "+e+` 
`+t+"\n```",isLoading:!r,actions:(0,x.jsx)(c.ActionPanel,{children:(0,x.jsx)(c.Action.CopyToClipboard,{content:t,shortcut:{modifiers:["cmd"],key:"c"}})})})},On=e=>{let n=`
    tell application "System Events"
      do shell script "/Applications/kitty.app/Contents/MacOS/kitty -1 kitten @ launch --hold ${e.replaceAll('"','\\"')}"
    end tell
  `;$(n)},Nn=e=>{let t=`
    -- Set this property to true to open in a new window instead of a new tab
    property open_in_new_window : false

    on new_window()
    	tell application "iTerm" to create window with default profile
    end new_window

    on new_tab()
    	tell application "iTerm" to tell the first window to create tab with default profile
    end new_tab

    on call_forward()
    	tell application "iTerm" to activate
    end call_forward

    on is_running()
    	application "iTerm" is running
    end is_running

    on is_processing()
    	tell application "iTerm" to tell the first window to tell current session to get is processing
    end is_processing

    on has_windows()
    	if not is_running() then return false
    	if windows of application "iTerm" is {} then return false
    	true
    end has_windows

    on send_text(custom_text)
    	tell application "iTerm" to tell the first window to tell current session to write text custom_text
    end send_text

    -- Main
    if has_windows() then
      if open_in_new_window then
        new_window()
      else
        new_tab()
      end if
    else
    	-- If iTerm is not running and we tell it to create a new window, we get two
    	-- One from opening the application, and the other from the command
    	if is_running() then
    		new_window()
    	else
    		call_forward()
    	end if
    end if


    -- Make sure a window exists before we continue, or the write may fail
    repeat until has_windows()
    	delay 0.01
    end repeat

    send_text("${e.replaceAll('"','\\"')}")
    call_forward()
  `;$(t)},qn=e=>{let t=`
      -- For the latest version:
      -- https://github.com/DavidMChan/custom-alfred-warp-scripts

      -- Set this property to true to always open in a new window
      property open_in_new_window : true

      -- Set this property to true to always open in a new tab
      property open_in_new_tab : false

      -- Don't change this :)
      property opened_new_window : false

      -- Handlers
      on new_window()
          tell application "System Events" to tell process "Warp"
              click menu item "New Window" of menu "File" of menu bar 1
              set frontmost to true
          end tell
      end new_window

      on new_tab()
          tell application "System Events" to tell process "Warp"
              click menu item "New Tab" of menu "File" of menu bar 1
              set frontmost to true
          end tell
      end new_tab

      on call_forward()
          tell application "Warp" to activate
      end call_forward

      on is_running()
          application "Warp" is running
      end is_running

      on has_windows()
          if not is_running() then return false
          tell application "System Events"
              if windows of process "Warp" is {} then return false
          end tell
          true
      end has_windows

      on send_text(custom_text)
          tell application "System Events"
              keystroke custom_text
          end tell
      end send_text


      -- Main
      if not is_running() then
          call_forward()
          set opened_new_window to true
      else
          call_forward()
          set opened_new_window to false
      end if

      if has_windows() then
          if open_in_new_window and not opened_new_window then
              new_window()
          else if open_in_new_tab and not opened_new_window then
              new_tab()
          end if
      else
          new_window()
      end if


      -- Make sure a window exists before we continue, or the write may fail
      repeat until has_windows()
          delay 0.5
      end repeat
      delay 0.5

      send_text("${e}")
      call_forward()
  `;$(t)},$n=e=>{let t=`
  tell application "Terminal"
    do script "${e.replaceAll('"','\\"')}"
    activate
  end tell
  `;$(t)};function Bn(e){let[t,n]=(0,_.useState)(""),[r,o]=(0,_.useState)(),[i,s]=ke("recently-used",[]),a=le.default.existsSync("/Applications/iTerm.app"),l=le.default.existsSync("/Applications/kitty.app"),u=le.default.existsSync("/Applications/Warp.app"),p=h=>{s(f=>f.find(E=>E===h)?f:[h,...f].slice(0,10))};(0,_.useEffect)(()=>{o([...new Set(He().reverse())])},[o]);let{arguments_terminal_type:g,arguments_terminal:w}=(0,c.getPreferenceValues)();if((0,_.useEffect)(()=>{if(e.arguments?.command&&w)switch(p(e.arguments.command),(0,c.showHUD)("Ran command in "+g),(0,c.popToRoot)(),(0,c.closeMainWindow)(),g){case"kitty":On(e.arguments.command);break;case"iTerm":Nn(e.arguments.command);break;case"Warp":qn(e.arguments.command);break;default:$n(e.arguments.command);break}},[e.arguments]),e.arguments?.command)return w?null:(0,x.jsx)(kn,{cmd:e.arguments.command});let S=[];return t&&S.push({category:"New command",items:[t]}),i.length>0&&S.push({category:"Raycast History",items:i.filter(h=>h.includes(t)).slice(0,50)}),r!==void 0&&r.length>0&&S.push({category:"Bash History",items:r.filter(h=>h.includes(t)).slice(0,50)}),(0,x.jsx)(c.List,{isLoading:r===void 0,enableFiltering:!1,onSearchTextChange:n,navigationTitle:"Shell command",searchBarPlaceholder:"Enter shell-command",children:S.map(h=>(0,x.jsx)(c.List.Section,{title:h.category,children:h.items.map((f,E)=>(0,x.jsx)(c.List.Item,{icon:c.Icon.Terminal,title:f,actions:(0,x.jsxs)(c.ActionPanel,{children:[(0,x.jsx)(c.Action.Push,{title:"Execute",icon:c.Icon.List,onPush:()=>p(f),target:(0,x.jsx)(kn,{cmd:f})}),l?(0,x.jsx)(c.Action,{title:"Execute in kitty.app",icon:c.Icon.Window,onAction:()=>{(0,c.closeMainWindow)(),(0,c.popToRoot)(),p(f),On(f)}}):null,a?(0,x.jsx)(c.Action,{title:"Execute in iTerm.app",icon:c.Icon.Window,onAction:()=>{(0,c.closeMainWindow)(),(0,c.popToRoot)(),p(f),Nn(f)}}):null,u?(0,x.jsx)(c.Action,{title:"Execute in Warp.app",icon:c.Icon.Window,onAction:()=>{(0,c.closeMainWindow)(),(0,c.popToRoot)(),p(f),qn(f)}}):null,(0,x.jsx)(c.Action,{title:"Execute in Terminal.app",icon:c.Icon.Window,onAction:()=>{(0,c.closeMainWindow)(),(0,c.popToRoot)(),p(f),$n(f)}}),(0,x.jsx)(c.Action.CopyToClipboard,{title:"Copy to Clipboard",content:f,onCopy:()=>{p(f)}})]})},E))},h.category))})}