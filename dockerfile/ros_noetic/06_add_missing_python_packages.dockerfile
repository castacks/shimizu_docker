ARG base_image
FROM ${base_image}

RUN pip3 install --no-cache-dir pandas
RUN ln -s /usr/bin/python3 /usr/bin/python

# entrypoint command
CMD /bin/bash
