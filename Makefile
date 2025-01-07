# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aherrman <aherrman@student.42mulhouse.fr>  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/24 10:04:23 by aherrman          #+#    #+#              #
#    Updated: 2023/05/30 14:10:20 by aherrman         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = push_swap

SRCS =	push_swap.c\
		ft_list_check_int.c\
		ft_verif_av.c\
		ft_char_to_int_list.c\
		ft_error.c\
		ft_utils_chain_list1.c\
		ft_utils_chain_list2.c\
		ft_utils_chain_list3.c\
		ft_move.c\
		ft_ranking.c\
		ft_sort_other.c\
		ft_tri.c\
		ft_sort_last_step.c\
		ft_s.c\

SRCST = test/ft_print_list.c\

OBJST = $(SRCST:.c=.o)
	  
OBJS = $(SRCS:.c=.o)

CC = gcc
CFLAGS = -g3 -Wall -Werror -Wextra
RM = rm -rf
INC = libft/libft.a\

.c.o:
	@$(CC) $(CFLAGS) -c $< -o $(<:.c=.o)

all:	$(NAME)

$(NAME):	$(OBJS) 
	@make all -C ./libft
	@$(CC) $(FLAG) $(OBJS) $(INC) -o $(NAME)
	@echo "Compilation de $(NAME) terminée."

debug:	$(OBJS)
	@make all -C ./libft
	@$(CC) $(FLAG) -fsanitize=address $(OBJS) $(INC) -o $(NAME)
	@echo "Compilation en mode debug terminée."

test: $(OBJS) $(OBJST)
	@make all -C ./libft
	@$(CC) $(FLAG) $(OBJS) $(OBJST) $(INC) -o $(NAME)
	@echo "Compilation avec tests terminée."

testd: $(OBJS) $(OBJST)
	@make all -C ./libft
	@$(CC) $(FLAG) -fsanitize=address $(OBJS) $(OBJST) $(INC) -o $(NAME)
	@echo "Compilation avec tests en mode debug terminée."

visualizer: $(OBJS) $(OBJST)
	@make all -C ./libft
	echo "Installation du visualizer..."
	@if [ ! -d "./visualizer" ]; then \
		echo "Clonage du repository visualizer..."; \
		git clone https://github.com/o-reo/push_swap_visualizer.git visualizer; \
	fi
	@if [ ! -d "./visualizer/build" ]; then \
		echo "Création du dossier build et configuration avec CMake..."; \
		mkdir -p visualizer/build; \
		cd visualizer/build && cmake .. && make; \
	fi
	@echo "Compilation avec le visualizer terminée."

clean:
	@$(RM) $(OBJS)
	@$(RM) $(OBJST)
	@make clean -C ./libft
	@echo "Nettoyage des fichiers objets terminé."

fclean:	clean
	@$(RM) $(NAME)
	@make fclean -C ./libft
	@echo "Nettoyage complet terminé."

re:	fclean all
