/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   EnvFileGenerator.cpp                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/17 15:20:35 by aaugu             #+#    #+#             */
/*   Updated: 2024/05/22 18:04:19 by aaugu            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "EnvFileGenerator.hpp"
#include <fstream>
#include <iostream>
#include <errno.h>
#include <string.h>

/* ************************************************************************** */
/*                          CONSTRUCTORS & DESTRUCTOR                         */
/* ************************************************************************** */

EnvFileGenerator::EnvFileGenerator(void) {}

EnvFileGenerator::~EnvFileGenerator(void) {}

/* ************************************************************************** */
/*                              PUBLIC FUNCTION                               */
/* ************************************************************************** */

int	EnvFileGenerator::generateEnv(std::string pathToSecrets)
{
	std::string		envFile = ".env";

	copyEnvTemplate(envFile);
	
	fillEnvFile(pathToSecrets + "/credentials.txt", envFile);
	fillEnvFile(pathToSecrets + "/db_password.txt", envFile);
	fillEnvFile(pathToSecrets + "/db_root_password.txt", envFile);

	if ( isEnvFileComplete() == true )
		return (0);
	else
		return (1);
}

/* ************************************************************************** */
/*                               FILL ENV UTILS                               */
/* ************************************************************************** */

int		EnvFileGenerator::copyEnvTemplate(std::string envFile)
{
	std::string	line;

	std::ifstream	iFS;
	std::ofstream	oFS;
	if ( openStreams(&iFS, "srcs/requirements/tools/.env_template", &oFS, envFile) == -1 )
		return (1);

	while (std::getline(iFS, line))
		oFS << line << std::endl;

	iFS.close();
	oFS.close();

	return (0);
}

int	EnvFileGenerator::fillEnvFile(std::string inFile, std::string envFile)
{
	std::string	line;
	size_t		pos;

	std::ifstream	iFS;
	if ( openInFileStream(&iFS, inFile) == -1 )
		return (1);

	while ( std::getline(iFS, line) )
	{
		pos = line.find("=");
		if ( pos != std::string::npos )
		{
			std::string	target = line.substr(0, pos + 1);
			replaceTargetInEnvFile(target, line, envFile);
		}
	}

	iFS.close();
	return (0);
}

int	EnvFileGenerator::replaceTargetInEnvFile(std::string& target, std::string replace, std::string envFile)
{
	std::string	line;
	size_t		pos;

	std::ifstream	iFS;
	if ( openInFileStream(&iFS, envFile) == -1 )
		return (1);
	
	while ( std::getline(iFS, line) )
	{
		pos = line.find(target);
		if ( pos != std::string::npos )
		{
			line.erase(0, line.size());
			if ( !replace.empty() )
				line.insert(0, replace);
		}
	}

	iFS.close();
	return (0);
}

/* ************************************************************************** */
/*                                  CHECKS                                    */
/* ************************************************************************** */

int		EnvFileGenerator::isEnvFileComplete()
{
	return (0);
}

/* ************************************************************************** */
/*                               STREAM UTILS                                 */
/* ************************************************************************** */

int		EnvFileGenerator::openStreams(std::ifstream* iFS, std::string inFile, std::ofstream* oFS, std::string outFile)
{
	if (openInFileStream(iFS, inFile) == -1)
		return (1);

	if (openOutFileStream(oFS, outFile) == -1)
		return (1);

	return (0);
}

int		EnvFileGenerator::openOutFileStream(std::ofstream* oFS, std::string outFile)
{
	oFS->open(outFile, std::fstream::out);
	if (!oFS->good())
	{
		std::cout << "Error:" << outFile << ": " << strerror(errno) << std::endl;
		return (-1);
	}
	return (0);
}

int		EnvFileGenerator::openInFileStream(std::ifstream* iFS, std::string inFile)
{
	iFS->open(inFile, std::fstream::in);
	if (!iFS->good())
	{
		std::cout << "Error:" << inFile << ": " << strerror(errno) << std::endl;
		return (-1);
	}
	return (0);
}