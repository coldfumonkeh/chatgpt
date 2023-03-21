component accessors="true" {

    property name="apiKey" type="string" default="";
    property name="organization" type="string" default="";
    property name="apiEndpoint" type="string" default="https://api.openai.com/v1/";

    /** Constructor **/
    public chatgpt function init(
        required string apiKey,
        string organization = "",
        string apiEndpoint = "https://api.openai.com/v1/"
    ){
        setConfig( argumentCollection = arguments );
        return this;
    }

    public void function setConfig(
        required string apiKey,
        string organization = "",
        string apiEndpoint = "https://api.openai.com/v1/"
    ){
        setApiKey( arguments.apiKey );
        setOrganization( arguments.organization );
        setApiEndpoint( arguments.apiEndpoint );
    }

    /**
     * Lists the currently available models, and provides basic information about each one such as the owner and availability.
     */
    public struct function listModels(){
        return makeRequest( endpoint = 'models' );
    }

    /**
     * Retrieve a model
     *
     * @model The ID of the model to use for this request
     */
    public struct function getModel( required string model ){
        return makeRequest( endpoint = 'models/#arguments.model#' );
    }

    /**
     * Creates a completion for the provided prompt and parameters
     *
     * @model ID of the model to use.
     * @prompt The prompt(s) to generate completions for, encoded as a string, array of strings, array of tokens, or array of token arrays. Note that <|endoftext|> is the document separator that the model sees during training, so if a prompt is not specified the model will generate as if from the beginning of a new document.
     * @suffix The suffix that comes after a completion of inserted text.
     * @max_tokens The maximum number of tokens to generate in the completion. The token count of your prompt plus max_tokens cannot exceed the model's context length. Most models have a context length of 2048 tokens (except for the newest models, which support 4096).
     * @temperature What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.
     * @top_p An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered. We generally recommend altering this or temperature but not both.
     * @n How many completions to generate for each prompt. Note: Because this parameter generates many completions, it can quickly consume your token quota. Use carefully and ensure that you have reasonable settings for max_tokens and stop.
     * @stream Whether to stream back partial progress. If set, tokens will be sent as data-only server-sent events as they become available, with the stream terminated by a data: [DONE] message.
     * @logprobs Include the log probabilities on the logprobs most likely tokens, as well the chosen tokens. For example, if logprobs is 5, the API will return a list of the 5 most likely tokens. The API will always return the logprob of the sampled token, so there may be up to logprobs+1 elements in the response. The maximum value for logprobs is 5.
     * @echo Echo back the prompt in addition to the completion
     * @stop Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
     * @presence_penalty Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
     * @frequency_penalty Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
     * @best_of Generates best_of completions server-side and returns the "best" (the one with the highest log probability per token). Results cannot be streamed. When used with n, best_of controls the number of candidate completions and n specifies how many to return – best_of must be greater than n. Note: Because this parameter generates many completions, it can quickly consume your token quota. Use carefully and ensure that you have reasonable settings for max_tokens and stop.
     */
    public function completion(
        required string model,
        required array prompt,
        string suffix,
        numeric max_tokens,
        numeric temperature,
        numeric top_p,
        numeric n,
        boolean stream,
        numeric logprobs,
        boolean echo,
        array stop,
        numeric max_tokens,
        numeric presence_penalty,
        numeric frequency_penalty,
        numeric best_of
    ){
        return makeRequest(
            method   = "POST",
            endpoint = 'completions',
            params   = filterParams( arguments )
        );
    }

    public function chatCompletion(
        required string model,
        required array messages,
        numeric temperature,
        numeric top_p,
        numeric n,
        boolean stream,
        array stop,
        numeric max_tokens,
        numeric presence_penalty,
        numeric frequency_penalty
    ){
        return makeRequest(
            method   = "POST",
            endpoint = 'chat/completions',
            params   = filterParams( arguments )
        );
    }

    /**
     * Creates a new edit for the provided input, instruction, and parameters.
     *
     * @model ID of the model to use. You can use the text-davinci-edit-001 or code-davinci-edit-001 model with this endpoint.
     * @input The input text to use as a starting point for the edit.
     * @instruction The instruction that tells the model how to edit the prompt.
     * @n How many edits to generate for the input and instruction.
     * @temperature What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.
     * @top_p An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered. We generally recommend altering this or temperature but not both.
     */
    public function createEdit(
        required string model,
        string input = '',
        required string instruction,
        numeric n,
        numeric temperature,
        numeric top_p
    ){
        return makeRequest(
            method   = "POST",
            endpoint = 'edits',
            params   = filterParams( arguments )
        );
    }

    /**
     * Creates an image given a prompt.
     *
     * @prompt A text description of the desired image(s). The maximum length is 1000 characters.
     * @n The number of images to generate. Must be between 1 and 10.
     * @size The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024
     * @response_format The format in which the generated images are returned. Must be one of url or b64_json
     */
    public function createImage(
        required string prompt,
        numeric n,
        string size,
        string response_format
    ){
        return makeRequest(
            method   = "POST",
            endpoint = 'images/generations',
            params   = filterParams( arguments )
        );
    }

    /**
     * Creates an embedding vector representing the input text.
     *
     * @model ID of the model to use
     * @input Input text to get embeddings for, encoded as a string or array of tokens. To get embeddings for multiple inputs in a single request, pass an array of strings or array of token arrays. Each input must not exceed 8192 tokens in length.
     */
    public function createEmbeddings(
        required string model,
        required array input
    ){
        return makeRequest(
            method   = "POST",
            endpoint = 'embeddings',
            params   = filterParams( arguments )
        );
    }

    /**
     * Classifies if text violates OpenAI's Content Policy
     *
     * @input The input text to classify
     * @model Two content moderations models are available: text-moderation-stable and text-moderation-latest. The default is text-moderation-latest which will be automatically upgraded over time. This ensures you are always using our most accurate model. If you use text-moderation-stable, we will provide advanced notice before updating the model. Accuracy of text-moderation-stable may be slightly lower than for text-moderation-latest.
     */
    public function createModeration(
        required string input,
        string model
    ){
        return makeRequest(
            method   = "POST",
            endpoint = 'moderations',
            params   = filterParams( arguments )
        );
    }


    /***** PRIVATE DANCER *****/
    private struct function makeRequest(
        required string method = 'GET',
        required string endpoint,
        string contentType = 'application/json',
        struct params
    ){
        cfhttp( url="#getApiEndpoint()##arguments.endpoint#", method='#arguments.method#', result="apiResult" ){
            cfhttpparam( type="header", name="Authorization", value="Bearer #getAPIKey()#" );
            cfhttpparam( type="header", name="Content-Type", value=arguments.contentType );
            if( arguments.contentType == 'application/json' && arguments.method == 'POST' ){
                cfhttpparam( type="body", value="#serializeJSON( arguments.params )#" );
            }
            if( arguments.contentType == 'multipart/form-data' && arguments.method == 'POST' ){
                for( item in arguments.params ){
                    cfhttpparam( type="formfield", name="#item#", value="#arguments.params[ item ]#" );
                }
            }
        }
        return deserializeJSON( apiResult.fileContent );
    }

    private struct function filterParams( required struct params ){
        var filtered = {};
        for( var key in arguments.params ){
            if( !isEmpty( arguments.params[ key ] ) ){
                filtered[ key ] = arguments.params[ key ];
            }
        }
        return filtered;
    }
    /***** DANCING FOR MONEY *****/

}