FasdUAS 1.101.10   ��   ��    k             l     ��  ��    + % -*- coding:utf-8 mode:applescript-*-     � 	 	 J   - * -   c o d i n g : u t f - 8   m o d e : a p p l e s c r i p t - * -   
  
 l     ��  ��    * $ save this as ToggleEmacsClient.scpt     �   H   s a v e   t h i s   a s   T o g g l e E m a c s C l i e n t . s c p t      l     ��  ��    7 1 start QuickSilver ,add a trigger to this script      �   b   s t a r t   Q u i c k S i l v e r   , a d d   a   t r i g g e r   t o   t h i s   s c r i p t        l     ��  ��      ;;;###autoload     �      ; ; ; # # # a u t o l o a d      l     ��  ��      (defun gui-frame-cnt()     �   .   ( d e f u n   g u i - f r a m e - c n t ( )      l     ��   !��     !    (let ((gui-frame-cnt 0))    ! � " " 6       ( l e t   ( ( g u i - f r a m e - c n t   0 ) )   # $ # l     �� % &��   % / )     (dolist (frame (visible-frame-list))    & � ' ' R           ( d o l i s t   ( f r a m e   ( v i s i b l e - f r a m e - l i s t ) ) $  ( ) ( l     �� * +��   * ' !       (with-selected-frame frame    + � , , B               ( w i t h - s e l e c t e d - f r a m e   f r a m e )  - . - l     �� / 0��   / 7 1         (when (frame-parameter frame 'window-id)    0 � 1 1 b                   ( w h e n   ( f r a m e - p a r a m e t e r   f r a m e   ' w i n d o w - i d ) .  2 3 2 l     �� 4 5��   4 ; 5           (setq gui-frame-cnt (1+ gui-frame-cnt)))))    5 � 6 6 j                       ( s e t q   g u i - f r a m e - c n t   ( 1 +   g u i - f r a m e - c n t ) ) ) ) ) 3  7 8 7 l     �� 9 :��   9       gui-frame-cnt))    : � ; ; (           g u i - f r a m e - c n t ) ) 8  < = < l     ��������  ��  ��   =  > ? > l    Y @���� @ O     Y A B A Q    X C D E C k    O F F  G H G r     I J I I   �� K��
�� .sysoexecTEXT���     TEXT K m     L L � M M L e m a c s c l i e n t   - e   ' ( >   ( g u i - f r a m e - c n t )   0 ) '��   J o      ���� 0 framevisible frameVisible H  N�� N Z    O O P�� Q O >    R S R o    ���� 0 framevisible frameVisible S m     T T � U U  t P k    * V V  W X W l   �� Y Z��   Y 1 + there is a not a visible frame, launch one    Z � [ [ V   t h e r e   i s   a   n o t   a   v i s i b l e   f r a m e ,   l a u n c h   o n e X  \ ] \ I   �� ^��
�� .sysoexecTEXT���     TEXT ^ m     _ _ � ` ` " e m a c s c l i e n t   - c   - n��   ]  a b a O    ( c d c r    ' e f e m     ��
�� boovtrue f n       g h g 1   $ &��
�� 
pisf h 4     $�� i
�� 
prcs i m   " # j j � k k 
 E m a c s d m     l l�                                                                                  sevs  alis    �  OSXDisk                    Н�5H+   ,�System Events.app                                               0��ЏN�        ����  	                CoreServices    Н��      Ў�a     ,� ,� ,�  8OSXDisk:System: Library: CoreServices: System Events.app  $  S y s t e m   E v e n t s . a p p    O S X D i s k  -System/Library/CoreServices/System Events.app   / ��   b  m n m l  ) )��������  ��  ��   n  o�� o l  ) )�� p q��   p * $tell application "Emacs" to activate    q � r r H t e l l   a p p l i c a t i o n   " E m a c s "   t o   a c t i v a t e��  ��   Q k   - O s s  t u t l  - -��������  ��  ��   u  v w v l  - -�� x y��   x V P	do shell script "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient  -c -n"    y � z z � 	 d o   s h e l l   s c r i p t   " / A p p l i c a t i o n s / E m a c s . a p p / C o n t e n t s / M a c O S / b i n / e m a c s c l i e n t     - c   - n " w  { | { l  - -�� } ~��   } + %	tell application "Emacs" to activate    ~ �   J 	 t e l l   a p p l i c a t i o n   " E m a c s "   t o   a c t i v a t e |  ��� � O   - O � � � Z   1 N � ��� � � n   1 8 � � � 1   5 7��
�� 
pisf � 4   1 5�� �
�� 
prcs � m   3 4 � � � � � 
 E m a c s � r   ; C � � � m   ; <��
�� boovfals � n       � � � 1   @ B��
�� 
pvis � 4   < @�� �
�� 
prcs � m   > ? � � � � � 
 E m a c s��   � r   F N � � � m   F G��
�� boovtrue � n       � � � 1   K M��
�� 
pisf � 4   G K�� �
�� 
prcs � m   I J � � � � � 
 E m a c s � m   - . � ��                                                                                  sevs  alis    �  OSXDisk                    Н�5H+   ,�System Events.app                                               0��ЏN�        ����  	                CoreServices    Н��      Ў�a     ,� ,� ,�  8OSXDisk:System: Library: CoreServices: System Events.app  $  S y s t e m   E v e n t s . a p p    O S X D i s k  -System/Library/CoreServices/System Events.app   / ��  ��  ��   D R      ������
�� .ascrerr ****      � ****��  ��   E k   W W � �  � � � l  W W�� � ���   � D > -- daemon is not running, start the daemon and open a frame		    � � � � |   - -   d a e m o n   i s   n o t   r u n n i n g ,   s t a r t   t h e   d a e m o n   a n d   o p e n   a   f r a m e 	 	 �  � � � l  W W�� � ���   � N H do shell script "/Applications/Emacs.app/Contents/MacOS/Emacs --daemon"    � � � � �   d o   s h e l l   s c r i p t   " / A p p l i c a t i o n s / E m a c s . a p p / C o n t e n t s / M a c O S / E m a c s   - - d a e m o n " �  � � � l  W W�� � ���   � U O do shell script "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c -n"    � � � � �   d o   s h e l l   s c r i p t   " / A p p l i c a t i o n s / E m a c s . a p p / C o n t e n t s / M a c O S / b i n / e m a c s c l i e n t   - c   - n " �  � � � l  W W�� � ���   � . ( -- bring the visible frame to the front    � � � � P   - -   b r i n g   t h e   v i s i b l e   f r a m e   t o   t h e   f r o n t �  � � � l  W W�� � ���   � . ( tell i term application "System Events"    � � � � P   t e l l   i   t e r m   a p p l i c a t i o n   " S y s t e m   E v e n t s " �  � � � l  W W�� � ���   � 0 * 	set frontmost of process "Emacs" to true    � � � � T   	 s e t   f r o n t m o s t   o f   p r o c e s s   " E m a c s "   t o   t r u e �  ��� � l  W W�� � ���   �  	 end tell    � � � �    e n d   t e l l��   B m      � ��                                                                                  ITRM  alis    :  OSXDisk                    Н�5H+   ,�	iTerm.app                                                       ���}��        ����  	                Applications    Н��      �}Ul     ,�  OSXDisk:Applications: iTerm.app    	 i T e r m . a p p    O S X D i s k  Applications/iTerm.app  / ��  ��  ��   ?  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  ��� � l     ��������  ��  ��  ��       �� � ���   � ��
�� .aevtoappnull  �   � **** � �� ����� � ���
�� .aevtoappnull  �   � **** � k     Y � �  >����  ��  ��   �   �  � L���� T _ l�� j�� � ��� �����
�� .sysoexecTEXT���     TEXT�� 0 framevisible frameVisible
�� 
prcs
�� 
pisf
�� 
pvis��  ��  �� Z� V M�j E�O�� �j O� 
e*��/�,FUOPY $� *��/�,E f*��/�,FY 
e*��/�,FUW X  hUascr  ��ޭ