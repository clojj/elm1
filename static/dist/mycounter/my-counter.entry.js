const h = window.mycounter.h;

class MyName {
    constructor() {
        this.start = 1;
        this.max = 100;
        this.min = 0;
        this.step = 1;
    }
    /*
    @Listen('message')
      messageHandler(event: CustomEvent) {
        console.log('Received the custom message event: ', event.detail);
      }
     */
    componentWillLoad() {
        this.value = this.start;
    }
    increment() {
        const newValue = this.value + this.step;
        this.value = newValue > this.max ? this.max : newValue;
        this.message.emit(this.value);
    }
    decrement() {
        const newValue = this.value - this.step;
        this.value = newValue < this.min ? this.min : newValue;
        this.message.emit(this.value);
    }
    render() {
        return (h("div", null,
            h("button", { class: 'plus', type: "button", onClick: () => this.increment() }, "+"),
            h("span", null, this.value),
            h("button", { class: 'minus', type: "button", onClick: () => this.decrement() }, "-")));
    }
    static get is() { return "my-counter"; }
    static get properties() { return {
        "max": {
            "type": Number,
            "attr": "max"
        },
        "min": {
            "type": Number,
            "attr": "min"
        },
        "start": {
            "type": Number,
            "attr": "start"
        },
        "step": {
            "type": Number,
            "attr": "step"
        },
        "value": {
            "state": true
        }
    }; }
    static get events() { return [{
            "name": "message",
            "method": "message",
            "bubbles": true,
            "cancelable": true,
            "composed": true
        }]; }
    static get style() { return ".plus {\n  background: rgb(218, 48, 18);\n}\n.minus {\n  background: rgb(49, 61, 221);\n}"; }
}

export { MyName as MyCounter };
