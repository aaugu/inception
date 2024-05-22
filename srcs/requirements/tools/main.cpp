/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.cpp                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/17 15:32:41 by aaugu             #+#    #+#             */
/*   Updated: 2024/05/22 17:48:58 by aaugu            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <iostream>
#include "EnvFileGenerator.hpp"

int	main(int ac, char** av)
{
	if (ac != 2)
	{
		std::cout << "Error: Wrong number of arguments" << std::endl;
		exit (1);
	}

	EnvFileGenerator efg;

	if ( efg.generateEnv(av[1]) == 1 )
		exit (1);
	
	return (0);
}