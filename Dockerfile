FROM eclipse-temurin:25-jammy

ARG USER_ID
ARG GROUP_ID
ARG USER_NAME=mc

RUN groupadd -g ${GROUP_ID} ${USER_NAME} && useradd -m -u ${USER_ID} -g ${GROUP_ID} -s /bin/bash ${USER_NAME}
USER $USER_NAME

WORKDIR /mc
# mount server dir to /mc
# -v ./server:/mc
VOLUME [ "/mc" ]

ENTRYPOINT [ "java", "-jar", "./server.jar" ]
