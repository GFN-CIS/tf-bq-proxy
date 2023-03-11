FROM python:3
RUN python3 -m pip install --upgrade pip
COPY main.py /app/
COPY pyproject.toml /app/
RUN pip3 install -e /app/
CMD [ "python", "/app/main.py" ]
