/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   EnvFileGenerator.cpp                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/17 15:20:35 by aaugu             #+#    #+#             */
/*   Updated: 2024/05/22 18:29:53 by aaugu            ###   ########.fr       */
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

	std::ifstream	iFS;
	std::ofstream	oFS;
	if ( openStreams(&iFS, "srcs/requirements/tools/.env_template", &oFS, envFile) == -1 )
		return (1);

	fillEnvFile(&iFS, &oFS, pathToSecrets);

	iFS.close();
	oFS.close();

	if ( isEnvFileComplete() == true )
		return (0);
	else
		return (1);
}

/* ************************************************************************** */
/*                               FILL ENV UTILS                               */
/* ************************************************************************** */

int		EnvFileGenerator::fillEnvFile(std::ifstream* iFS, std::ofstream* oFS, std::string pathToSecrets)
{
	std::string	line;
	size_t		pos;


	while ( std::getline(*iFS, line) )
	{
		pos = line.find("=");
		if ( pos != std::string::npos )
		{
			std::string	target = line.substr(0, pos + 1);
			std::string	replace = "";
			int	res = searchForReplace(replace, target, pathToSecrets);
			if ( res == 1 )
				*oFS << line << std::endl;
			else if (res == -1)
				return (1);
			else
				*oFS << replace << std::endl;
		}
		else 
			*oFS << line << std::endl;
	}
	
	return (0);
}


int	EnvFileGenerator::searchForReplace(std::string& replace, std::string& target, std::string pathToSecrets)
{
	try
	{
		searchForReplaceInFile(replace, target, pathToSecrets + "/credentials.txt");
		if ( replace.empty() )
			searchForReplaceInFile(replace, target, pathToSecrets + "/db_password.txt");
		if ( replace.empty() )
			searchForReplaceInFile(replace, target, pathToSecrets + "/db_root_password.txt");
		if ( replace.empty() )
			return (1);
		return (0);
	}
	catch(const std::exception& e)
	{
		return (-1);
	}	
}

int	EnvFileGenerator::searchForReplaceInFile(std::string& replace, std::string& target, std::string filePath)
{
	std::string	line;
	size_t		pos;

	std::ifstream	iFS;
	if ( openInFileStream(&iFS, filePath) == -1 )
		throw;
	
	while ( std::getline(iFS, line) )
	{
		pos = line.find(target);
		if ( pos != std::string::npos )
		{
			replace = line;
			iFS.close();
			return (0);
		}
	}

	iFS.close();
	return (1);
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