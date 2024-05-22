/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   EnvFileGenerator.hpp                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/22 15:57:22 by aaugu             #+#    #+#             */
/*   Updated: 2024/05/22 18:23:44 by aaugu            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string>
#include <fstream>

class EnvFileGenerator
{
	private:
		// Fill env utils
		int	fillEnvFile(std::ifstream* iFS, std::ofstream* oFS, std::string pathToSecrets);
		int	searchForReplace(std::string& replace, std::string& target, std::string pathToSecrets);
		int	searchForReplaceInFile(std::string& replace, std::string& target, std::string filePath);

		// Stream utils
		int	openStreams(std::ifstream* iFS, std::string inFile, std::ofstream* oFS, std::string outFile);
		int	openInFileStream(std::ifstream* iFS, std::string inFile);
		int	openOutFileStream(std::ofstream* oFS, std::string outFile);
		
		// Checks
		int	isEnvFileComplete();


	public:
		EnvFileGenerator(void);
		~EnvFileGenerator();

		int generateEnv(std::string pathToSecrets);
};

