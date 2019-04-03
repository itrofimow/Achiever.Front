abstract class ISocialIntercationsApi {
  Future follow(String userId);

  Future unfollow(String userId);
}