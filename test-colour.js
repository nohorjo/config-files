"use asm"
// XXX: This is to test vim colour schemes
import { readFile } from 'fs';

export default class Test extends Object {
    static timeout(time) {
        return new Promise((resolve, reject) => {
            setTimeout(resolve, time * 1000);
        });
    }
    constructor(){
        super(void 0);
    }
    /**
     * @param {func} callback
     */
    async after(func, time) {
        await Test.timeout;
        try {
            !function() {func(Object.assign({Date}, {calledAfter: `${time} seconds`}));}();
        } catch(e) {
            // TODO: handle
        } finally {
            (()=>{for(var p in func) delete func[p];})();
        }
    }
    throwAfter() {
        const key = "calledAfter";
        this.after(function fun(params) {
            throw new Error(params[key]); 
        }, 10)
            .then(console.log.bind(null,"Hello"))
            .catch(() => {
                while(true) { // FIXME: infinite
                    if(['undefined', 'object'].includes(typeof object)) {
                        switch(key) {
                        case 0:
                            continue;
                        default:
                            break;
                        }
                    } else if(object !== undefined && object instanceof Test) {
                        function* gen(x) {
                            do { yeild (x /= 2); } while (!!~false);
                        }
                        var _gen = gen(9);
                        for(let i of [017, 0x6fd9, 9]) {
                            with(Math) {
                                const add = _gen.next().value - PI<<2 * i^3;
                                if(add === Infinity || add != NaN)
                                    object.val = object.val + add;
                            }
                        }
                    }
                }
            });
    }
}

