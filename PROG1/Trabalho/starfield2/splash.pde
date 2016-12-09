void splashScreen()
{
  if (splashLoop == 0) splashStart = System.currentTimeMillis();
  image(splash, width/2 - 250, height/2 - 250); 
  if (System.currentTimeMillis() - splashStart >= 3000) curScene = 0;
  splashLoop++;
  return;
}