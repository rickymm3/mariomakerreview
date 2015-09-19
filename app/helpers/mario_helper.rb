module MarioHelper

  def own_level?
    if current_user
      if @mario_level.user_id == current_user.id
        true
      end
    else
      false
    end
  end

  def can_rate?
    if own_level?
      false
    end
    if current_user
      if MarioRating.where(user_id: current_user.id, mario_level_id: @mario_level.id).exists?
        false
      else
        true
      end
    end
  end

  def update_mario_level_rank(level, mario_rating_params)
    ratings = MarioRating.where(mario_level_id: level.id)
    fun = level.fun_rank ||= 0
    puzzle = level.puzzle_rank ||= 0
    difficulty = level.difficulty_rank ||= 0
    overall = level.overall_rank ||= 0

    fun = (fun + mario_rating_params[:fun].to_i)/(ratings.count + 1)
    puzzle = (puzzle + mario_rating_params[:puzzle].to_i)/(ratings.count + 1)
    difficulty = (difficulty + mario_rating_params[:difficulty].to_i)/(ratings.count + 1)
    overall = (overall + mario_rating_params[:overall].to_i)/(ratings.count + 1)

    level.update_attributes(fun_rank:fun,puzzle_rank:puzzle,difficulty_rank:difficulty, overall_rank:overall)
  end

  def check_mario_image(level)
    unless level.ss_loc == ""
      image_tag(level.ss_loc, size: '160x120')
    else
      image_tag('no_image.png', size: '160x120')
    end
  end

  def mario_level_complete?(level)
    if current_user
      if MarioRating.where(user_id:current_user.id, mario_level_id: level.id).present?
        true
      else
        false
      end
    else
      false
    end
  end

end
