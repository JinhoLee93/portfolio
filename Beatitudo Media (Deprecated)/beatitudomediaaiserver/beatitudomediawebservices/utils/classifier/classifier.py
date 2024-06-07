import os
import json
import asyncio
from openai import OpenAI
from dotenv import load_dotenv

class GPTClient:
    def __init__(self):
        load_dotenv()
        self.client = OpenAI(api_key=os.getenv('OPENAI_API_KEY'))
        print('Starting Classifier')

    def create_clear_history_prompt():
        prompt = '이전까지의 대화 Context를 지우고 "네"를 Response로 보내.'

        return prompt

    def create_query_prompt(self, request):
        prompt = f'''While going through each and every sentence inside the input list {request},
        
                    if the current sentence is decided to feel "neutral," enter "부정적" inside its index and go to the next sentence.

                    If the current sentence is decided to feel "negative," enter "부정적" inside its index and go to the next sentence.
                    
                    If the current sentence is related to the politics, enter "부정적" inside its index and go to the next sentence.

                    If the current sentence is related to the entertainment industry, enter "부정적" inside its index and go to the next sentence.

                    If the current sentence is related to the stock market, enter "부정적" inside its index and go to the next sentence.

                    If the current sentence is related to the housing market, enter "부정적" inside its index and go to the next sentence.

                    If the current sentence is related to monetary interests, such as advertisements for companies, enter "부정적" inside its index and go to the next sentence.

                    If the current sentence is sexually inappropriate, enter "부정적" inside its index and go to the next sentence.

                    If the current sentence is decided to feel "positive," decide if the sentence feels sympathetic and, if it is, enter "Moving" inside its index and go to the next sentence.

                    If the current sentence is decided to feel great, enter "Amazing" inside its index and go to the next sentence.

                    If the current sentence is decided to feel cheerful, enter "Happy" inside its index and go to the next sentence.

                    If the current sentence is decided to feel humorous, enter "Funny" inside its index and go to the next sentence.

                    Return a list in the format ["부정적", "Moving", "Happy", "Amazing", ...] as the response.'''


        return prompt

    def send_query_prompt(self, request, to_clear_history=False):
        if to_clear_history:
            user_message = self.create_clear_history_prompt()
        else:
            user_message = self.create_query_prompt(request)

        response = self.client.chat.completions.create(
            model=os.getenv('GPT_MODEL'),
            messages=[
                { 
                    'role':'system', 'content':'Be extremely precise and concise.',
                    'role':'user', 'content':f'{user_message}' 
                }
            ],
            temperature=0
        )

        print('Ending Classifier')

        return response.choices[0].message.content
