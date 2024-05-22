/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   EnvFileGenerator.hpp                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/22 15:57:22 by aaugu             #+#    #+#             */
/*   Updated: 2024/05/22 17:35:38 by aaugu            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string>
#include <fstream>

class EnvFileGenerator
{
	private:
		// Fill env utils
		int	copyEnvTemplate(std::string envFile);
		int	fillEnvFile(std::string inFile, std::string envFile);
		int	replaceTargetInEnvFile(std::string& target, std::string replace, std::string envFile);

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

