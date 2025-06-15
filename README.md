# dev-playground: A Ready-to-Run Dockerized Development Environment for Brown Bag Sessions

This project provides a pre-configured Docker image designed to facilitate hands-on learning and knowledge sharing in brown bag sessions or workshops. The *presenter* creates a complete and isolated development environment tailored to the specific demonstration, and *participants* can quickly get started without needing to install or configure anything beyond Docker on their local machines.

This base image provides a foundation with:

*   A Linux environment (Ubuntu)
*   Git
*   VS Code Server (code-server) - a web-based IDE

The presenter will create a `Dockerfile` that builds upon this base, adding the necessary languages, libraries, and tools for the session. Participants simply need to obtain the `Dockerfile` and run it.

The goal is to provide a consistent and readily accessible platform for exploring new technologies, running code samples, and collaborating on projects. The presenter handles the setup, so participants can focus on learning and experimentation.

Think of it as a pre-packaged coding lab, ready to go with minimal effort!

## Prerequisites

*   [Docker](https://www.docker.com/) installed and running on your system (macOS, Windows, or Linux).

## Usage

1.  **Build the Docker Image:**

    ```bash
    docker build --no-cache -t dev-playground .
    ```

    This command builds the Docker image from the `Dockerfile` in the current directory. The `--no-cache` flag ensures that the image is built from scratch, avoiding any potential issues with cached layers.

2.  **Run the Docker Container:**

    ```bash
    docker run -d --name myDevPlayground -p 8080:8080 dev-playground
    ```

    This command runs the Docker image in detached mode (`-d`) and maps port `8080:8080` from your host machine to the container (for VS Code Server).

3.  **Access VS Code in Your Browser:**

    Open your web browser and go to the following address:

    ```
    http://localhost:8080
    ```

    You should see the VS Code interface running in your browser.

4.  **Cleanup When You're Done:**

    When you've finished working with the container, don't forget to stop and remove it to free up resources:

    ```bash
    docker stop myDevPlayground
    docker rm myDevPlayground
    ```

## Developing

Once you have the environment running, you can start developing:

1.  **Open VS Code in your browser (http://localhost:8080).**
2.  **Create a new project or open an existing one.** You'll be working in the `/home/developer/app` directory inside the container.
3.  **Write your Java/Spring code.**
4.  **Use the VS Code terminal to compile and run your code using Maven or directly with `java`.**

## Security Considerations

*   **Authentication Disabled:** This environment has authentication disabled for VS Code Server. This is convenient for a quick playground, but it's *not* secure for production use. If you plan to share this image or use it with sensitive data, you should enable authentication.
*   **Resource Limits:** Consider setting resource limits (CPU, memory) when running the container to prevent it from consuming too many resources on the host machine.

## Contributing

Feel free to contribute to this project by submitting pull requests or opening issues.