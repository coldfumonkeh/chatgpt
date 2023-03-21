# chatgpt

A ColdFusion CFC to interact with the chatgpt API

## Base Component

Instantiate the core component `chatgpt.cfc` and pass in the required properties like so:

```
var chat = new chatgpt(
    apiKey = 'xx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
);
```

### Example

Use chatgpt to create:

```
var resp = chat.chatCompletion(model='gpt-3.5-turbo',messages=[{"role": "user", "content": "Write me a poem about a summer day with popcorn and unicorns"}]);
```

## API Reference

The official API reference guide can be found at https://platform.openai.com/docs/api-reference/

MIT License

Copyright (c) 2023 Matt Gifford (Monkeh Works)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.