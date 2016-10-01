module CoursesHelper
  def courses_subject_url(subject_id)
    "/courses?subject=#{subject_id}"
  end

  def free_courses_subject_url(subject_id, archive)
    if archive
      "/courses/free/archive?subject=#{subject_id}"
    else
      "/courses/free?subject=#{subject_id}"
    end
  end

  def link_class(archive)
    archive ? 'text-decoration-none p2 left black border-bottom bold' : 'text-decoration-none p2 left gray'
  end
end
