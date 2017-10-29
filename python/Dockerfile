FROM python:3.4-alpine
#FROM docker-registry.default.svc:5000/chris1/python@sha256:fbaf81d11942f24baa3a48b905d1063419aff13b9e9a1ab5ec4f6e5ab5357845
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
