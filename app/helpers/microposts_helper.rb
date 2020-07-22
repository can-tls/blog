module MicropostsHelper
    def micropost_from_current_user?(post)
        return false if !current_user.present?

        post.user_id == current_user.id
    end
    #def tag_from_current_user(post)
    #    return SELECT  "tags".* FROM "tags" INNER JOIN "taggings" ON "tags"."id" = "taggings"."tag_id" WHERE "taggings"."micropost_id" = @post
    #end
end