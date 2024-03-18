init_project:
	mkdir server domain infra && \
	dotnet new sln && \
	dotnet new webapi -o server && \
	dotnet new classlib -o domain && \
	dotnet new classlib -o infra

clear_project:
	rm server domain infra -r
