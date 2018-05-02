/**
 * XXX: This is to test vim colour schemes
 */
import { readFile } from 'fs';

export default class Test {
    static timeout(time) {
        return new Promise((resolve, reject) => {
            setTimeout(resolve, time * 1000);
        });
    }
    constructor(){
        super();
    }
    async after(func, time) {
        await Test.timeout;
        try {
            func(Object.assign({}, {calledAfter: `${time} seconds`}));    
        } catch(e) {
            // TODO: handle
        }
    }
    throwAfter() {
        const key = "calledAfter";
        this.after(function fun(params) {
            let msg = params[key];
            var err = new Error(msg);
            throw err; 
        }, 10)
            .then(console.log.bind(null,"Hello"))
            .catch(() => {
                while(true) { // FIXME: infinite
                    if(['undefined', 'object'].includes(typeof object)) {
                        switch(key) {
                        case 0:
                            do { continue; } while (false);
                        default:
                            break;
                        }
                    } else if(object instanceof Test) {
                        break;
                    }
                }
            });
    }
}

