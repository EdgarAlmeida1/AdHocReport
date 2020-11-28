PGDMP     )    .            
    x            trabalho    12.4    12.4     (           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            )           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            *           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            +           1262    17325    trabalho    DATABASE     �   CREATE DATABASE trabalho WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Portuguese_Brazil.1252' LC_CTYPE = 'Portuguese_Brazil.1252';
    DROP DATABASE trabalho;
                postgres    false            �            1255    17462    all_games_team(integer)    FUNCTION     g  CREATE FUNCTION public.all_games_team(cod_time integer) RETURNS TABLE(nome_do_time character varying, nome_do_adversario character varying, placar_do_time integer, placar_do_adversario integer, local_da_partida character varying, hora_da_partida time without time zone, data_da_partida date)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
RETURN QUERY SELECT team.nome_time as nome_do_time, 
                    (SELECT nome_time FROM team WHERE id_time = game.time_visitante) as nome_do_adversario, 
                    game.pontos_time_casa as placar_do_time,
                    game.pontos_time_visitante as placar_do_adversario,
                    game.local_partida as local_da_partida,
                    game.hora_partida as hora_da_partida,
                    game.data_partida as data_da_partida

FROM game, team
WHERE team.id_time=cod_time;
END;
$$;
 7   DROP FUNCTION public.all_games_team(cod_time integer);
       public          postgres    false            �            1255    17460    jogos_time(integer)    FUNCTION     6  CREATE FUNCTION public.jogos_time(cod_time integer) RETURNS TABLE(nome_do_time character varying, nome_do_adversario character varying, placar_do_time integer, placar_do_adversario integer, local_da_partida character varying, data_da_partida date)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
RETURN QUERY SELECT team.nome_time as nome_do_time, 
                    (SELECT nome_time FROM team WHERE id_time = game.time_visitante) as nome_do_adversario, 
                    game.pontos_time_casa as placar_do_time,
                    game.pontos_time_visitante as placar_do_adversario,
                    game.local_partida as local_da_partida,
                    game.data_partida as data_da_partida

FROM game, team
WHERE team.id_time=134880 AND game.pontos_time_casa > game.pontos_time_visitante;
END;
$$;
 3   DROP FUNCTION public.jogos_time(cod_time integer);
       public          postgres    false            �            1259    17326    game    TABLE     r  CREATE TABLE public.game (
    id_partida integer NOT NULL,
    nome_partida character varying(100) NOT NULL,
    data_partida date,
    local_partida character varying(100),
    time_casa integer NOT NULL,
    time_visitante integer NOT NULL,
    pontos_time_casa integer NOT NULL,
    pontos_time_visitante integer NOT NULL,
    hora_partida time without time zone
);
    DROP TABLE public.game;
       public         heap    postgres    false            �            1259    17329    league    TABLE     #  CREATE TABLE public.league (
    id_liga integer NOT NULL,
    nome_liga character varying(50) NOT NULL,
    nome_alternativo_liga character varying(100),
    ano_formacao_liga integer NOT NULL,
    pais_liga character varying(50) NOT NULL,
    descricao character varying(5000) NOT NULL
);
    DROP TABLE public.league;
       public         heap    postgres    false            �            1259    17335    player    TABLE     r  CREATE TABLE public.player (
    id_jogador integer NOT NULL,
    id_time_jogador integer NOT NULL,
    nome_jogador character varying(100) NOT NULL,
    nacionalidade_jogador character varying(50) NOT NULL,
    data_nasc_jogador date NOT NULL,
    genero_jogador character varying(20) NOT NULL,
    altura_jogador double precision,
    peso_jogador double precision
);
    DROP TABLE public.player;
       public         heap    postgres    false            �            1259    17338    team    TABLE     	  CREATE TABLE public.team (
    id_time integer NOT NULL,
    nome_time character varying(100) NOT NULL,
    ano_formacao_time integer NOT NULL,
    estadio_time character varying(100),
    pais_time character varying(50) NOT NULL,
    liga_time integer NOT NULL
);
    DROP TABLE public.team;
       public         heap    postgres    false            �            1259    25633    team_league    TABLE     �   CREATE TABLE public.team_league (
    id_time integer NOT NULL,
    id_liga integer NOT NULL,
    nome_time character varying(50),
    nome_liga character varying(50)
);
    DROP TABLE public.team_league;
       public         heap    postgres    false            !          0    17326    game 
   TABLE DATA                 public          postgres    false    202   �(       "          0    17329    league 
   TABLE DATA                 public          postgres    false    203          #          0    17335    player 
   TABLE DATA                 public          postgres    false    204   6�       $          0    17338    team 
   TABLE DATA                 public          postgres    false    205   �      %          0    25633    team_league 
   TABLE DATA                 public          postgres    false    206   .-      �
           2606    17346    game game_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_pkey PRIMARY KEY (id_partida);
 8   ALTER TABLE ONLY public.game DROP CONSTRAINT game_pkey;
       public            postgres    false    202            �
           2606    17348    league league_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_pkey PRIMARY KEY (id_liga);
 <   ALTER TABLE ONLY public.league DROP CONSTRAINT league_pkey;
       public            postgres    false    203            �
           2606    17350    player player_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (id_jogador);
 <   ALTER TABLE ONLY public.player DROP CONSTRAINT player_pkey;
       public            postgres    false    204            �
           2606    25638    team_league team_league_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.team_league
    ADD CONSTRAINT team_league_pkey PRIMARY KEY (id_time, id_liga);
 F   ALTER TABLE ONLY public.team_league DROP CONSTRAINT team_league_pkey;
       public            postgres    false    206    206            �
           2606    17354    team team_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id_time);
 8   ALTER TABLE ONLY public.team DROP CONSTRAINT team_pkey;
       public            postgres    false    205            �
           1259    17355    idx_game    INDEX     ?   CREATE INDEX idx_game ON public.game USING btree (id_partida);
    DROP INDEX public.idx_game;
       public            postgres    false    202            �
           1259    17356 
   idx_player    INDEX     E   CREATE INDEX idx_player ON public.player USING btree (nome_jogador);
    DROP INDEX public.idx_player;
       public            postgres    false    204            �
           1259    17357    idx_team    INDEX     >   CREATE INDEX idx_team ON public.team USING btree (nome_time);
    DROP INDEX public.idx_team;
       public            postgres    false    205            �
           2606    17358    game game_time_casa_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_time_casa_fkey FOREIGN KEY (time_casa) REFERENCES public.team(id_time);
 B   ALTER TABLE ONLY public.game DROP CONSTRAINT game_time_casa_fkey;
       public          postgres    false    202    205    2714            �
           2606    17363    game game_time_visitante_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_time_visitante_fkey FOREIGN KEY (time_visitante) REFERENCES public.team(id_time);
 G   ALTER TABLE ONLY public.game DROP CONSTRAINT game_time_visitante_fkey;
       public          postgres    false    2714    205    202            �
           2606    17368    player player_id_time_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_id_time_fkey FOREIGN KEY (id_time_jogador) REFERENCES public.team(id_time);
 D   ALTER TABLE ONLY public.player DROP CONSTRAINT player_id_time_fkey;
       public          postgres    false    204    2714    205            �
           2606    25639 $   team_league team_league_id_liga_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_league
    ADD CONSTRAINT team_league_id_liga_fkey FOREIGN KEY (id_liga) REFERENCES public.league(id_liga);
 N   ALTER TABLE ONLY public.team_league DROP CONSTRAINT team_league_id_liga_fkey;
       public          postgres    false    206    2708    203            �
           2606    25644 $   team_league team_league_id_time_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_league
    ADD CONSTRAINT team_league_id_time_fkey FOREIGN KEY (id_time) REFERENCES public.team(id_time);
 N   ALTER TABLE ONLY public.team_league DROP CONSTRAINT team_league_id_time_fkey;
       public          postgres    false    2714    205    206            �
           2606    17383    team team_liga_time_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_liga_time_fkey FOREIGN KEY (liga_time) REFERENCES public.league(id_liga);
 B   ALTER TABLE ONLY public.team DROP CONSTRAINT team_liga_time_fkey;
       public          postgres    false    203    205    2708            !      x�ݽK�G��;?�"g�����<w�*�����ˢ$[#�*U�]Y���{�8<0`���qe{r`��1\�@��P�_7֊��GF�ޛ��%@��(�]��z�����߽����M�aw�wW�i����t���C3m���h�[�o�Ͷ��֏WM��u��z�l�?>t�n������8l��0~��#�O������F?>;���E�oX���o�'�nvMt��]�zt�w>��&z�D�n{�4��ys��	��I��O��)c��^�p~�M��"MR�Z�uɿ�$����������P)ʬ(�U(�����&�n����F�����7Q�=a���1��	5(I�?ē��_�Mt�޴�5��S2�ĥ�$���`����<�Q.�D���Ň�t(���RյƢD���$e�D_5��F��k��Qa*�
"!Gmm\��ߵ��Ő��&iY��d��"ia����y9�����1���L�k���s����}JO0��e��E�oQD��n�]l%��~�i ­Q]�U��''��3I�����x���)��T��l��׏BNv}�0N�/�����n�`\�%"�Lb�
�	�����J �{Hw"Q�lTd=JQ&u~lD��ѫ榻Z���hj����QK5!˃�������cKUخ4&S!j�����`L�O8l���il�M��4��K	�=��g�¦���ɋq�F?5����j��g�6�r���NQF� ��H�;��x����=�Aa1��75i��U�����Q�v��tLS7*����p?�0;�-5 %-$�3N%���w���H��M�%��"̊���$��(��; "�] ���ԥ�s�1�}����f��.�o��w᜗��ߔKJ6�(��( ��~~ �S���Ow�k��`QQ��2)��e#�b�I��^��St6tWw�`4��p�ÿ����I���|n��7hk^��pi@�᪔R�Bs�A��~�=�E�)�aI:�`�����J�����6�Jխ���`��k��S�=uB�Ԧ�W��+���ȖJSQ4%~>��/.2�r�t�@k�I؏�_z�C2 x�Ŀ�5�����k7���n$Pn���|"r�����k�u��"h����7�p+�a�j}�P����L4,��?��WSL>�8�����x��
}�k�<K"��s<�,�����y��H�Аf�4hBK�U��Y�W�c{��`�a�ȭ�[�*+�14e��ܢ�Ӌ`�n�)Nnt���`�K����e-�u�HqA!)����D�%�W��7q��"\pUK2��˪�z���J�°�*�'
$��"-���2�tD���4�w���]��m�B�5���[�fHdx)uJ�	�����P��3e��W��,J�${"\C�ڍ�r�яM߷�я���~��D?��C���8_��N�&�F	��:���q(o;^���Y7�X�V@~~��U�T��Hr��%��ƌSP,����Ÿ́��[
G�\4rOqHF���i��HT_� �������}�&��{�T+��8
�04Ӽ,����]\_�>p��e�Ն����A;�%���|AH�;��X9�*�+\cc����[H���U�lD��c��͢�a�؎9T�kg��Au 2\�G�@,B��VrP\�GM�?��xOh�u>�
�R�ˡ�<��U���q�Q&��N�54�ـ��}=w�J��g#z%Eci��__�uB��A�$���(I]��_t��/ыb����_��=���L�T�uj��S
�[��)�5KqIJ��lYe=`�Չa3m]k�?Ihj8��[Wz�n�&�`H��Qa�=��g�`My�7zq@L(�T�!��32�z�M�%�[N��>�2��p�F��t�)T�Z�಼g	:�
�k��CL�V�Ȃ�A���?���&*P���[�w�Qe �̹"랡���P���vC��XWlh���$�]k�ęH���蠅�����2­,'�(N��qk� ɥ���+W����66ו|�J�66t�"�A������]$yZ�J���g��)vǧ�����Ԭ"Y�'���i��˂ŷg�s� "y�����H��%vu:e��'L�dI^Y�pv���ƫ/��|l�4-i&�Y�P����Ȇ��?�W���G�Br�V���Y%8{vz���~�İ����>�DT��J�(�EQ � ����S&��_�n��輻��Y�P�;�
n��t�� �y6��f�M��8
�F��l#9 8��[�t!�-�g4��nh���%�r�8p"�0 �I�U�ﹿ����k�fE*��1r��� tY�cM����P�)�Hy!����"]<,�#*ɳ7{"����Q
3��ztY`�2��2�¡�����`] x�]��}�(�ө�B���;V7!-Rñ�%�iK��m�����"�0�ʖ��R��+�~���<���>�m��%]*(�ڳ�Av�Q��
?3s�RYI��&a)���n{�6 0۩Y��#)��&���K�IK"�w=L�x��,�k��T@�v��kݶژ�6B)���(�S�v@���ǳ("0�^A��f��|��?�F�tBL�9�Bg�0�Zw% ��?!����t�	,V��zƢ��$mf��|�#-��s��^iX\�U$P �"^�b��]�Ρ�kE��0�9,��F��E
�h�a"Ka"+��%���ȀL,�#�\��D=z�ܠҁ�	�X�:Q�֋�v!��9�V@�F�ɔ�;�` 򠵔p�閲�
�&/nŋ|�W3_�%�eB:���={�E;��es�������^��,,�'OL�(bP�{�l�"t�/N�'�����8�?���j-�S�ޑ�W��[*�$��"�$k���?t����B¿����$���	pv���u�$#��R�U��(K��52jO:�!��@��eb�A(�y��p��6T;��r�ƒJ���8V�"�|�<� �q݉���F{����j���.�����"w;e���e�����˂p�	�YX5}�~���Mwak��K��T�U�{4�0�Vxd�d7�_�Ӎ5��k���d��r��d�����,z5NC3ATj�`>E�!x��)ɲ�0�9k���~�4�Vf�t�%�9ycOU�g\�r�����n�4��S����tS&U����S�!(��������FR��O-�]!��B�<%����t'�9�4�����>�a�f�mW�i�ԣ���a.�Z,���Mh�im�K��*��ߧ�ϵy�E��_>V#�L� �T����)��������Ge?�v�����u5LB}�J��f�"f�Di�k�w�e�Ц���C��k̃�N̂��@(�+�b���H���.x�:4W��Ϋ<Pg$��H5u��n����'�T����	&���[�LhƲ<0A'j2ލ��{��v��b�E�	K�4T�&���K����0�}��v�m���w�eL���Y,MGU�-c��D�<+>m����Do���C�'K��xٗIQ�sa9n���]mG�sWs�N�F�,˺�&��@�VY��c��.p��:��Q�Uo�rTx����G���}s��f;qỌ���9Rl8"y!i=�*0p\��Ѵ�mV�8�K x�b�Z�(���"���t��|�����C����!`\T�'�Lv
�o�����ys��o���}��ӾT�pE,����}��v)"�Q�����J�]����k{�MP0i��Eg2Xy��S3b����=����q����w5�-��k�$V�ff�LW���U,x��k���?�@��"
����T�Z�Ty�)~�a19w���vxz2���q��)SK!I𤉼|KKQTV�Ϛ�˯�����1-캼��%E\����-Ԩb��'��ی+��ѫ���on�)��\AjԎ<��4��-�m�5����^�}F��D�1;;��K˲��9��k4P��8T���6��{�����4��m��()��z�����R�M�� �UY�KiJ�픤ۤ�8�oY�b�d1    p�����!
˥���R1�i����7�
�Vl$���,ΦP� nPr����<fP�d�Pom�<��X��׎����LY��a�S�l]�~��-�R.t'� ��J팩V�ҕƏ�f�Ge�G�����%ɦ��b���-�r��P���}(�klb�.*�K.�K�ϓ09*��G���KD��P�[�Rd*�!, �w��cJ���F�z)M��� �qj'��К���$�l�"�b���y۵�}��C��|���o�h='l�M���*���β	ߋc��$�E.��<��E5U{Խ�|�T`�y�
�ʮX�'o=�X�{>�S�c;��xH�
l�_ l{��5�Lp,�"��E!��~�}������8��~��jU0R��%Yшk<�y�ݏ7�t� �BRm%�D[�Ny3�"+P���XHH�聧~r�Bt
/�@[���}�$�����
?�����+��,�,���d8�ZU
��ة��R�k'���!]JD�p1���d�* ,b�Qҁ�
H��+[m��i<&Iꥼ�dZU��j��/r��������O��}{��t�df���T�ԣ��u����f�E��bZ��,�)�i��n���!nZ�Ӳ%]����P5,L<-�鄿k��G+�Swm����ι.��k��6�3VO�� �uC������z\��T���V���?�f��p%�G��"���WNN����N�����8AR��ɇ
���=/�i�Y��:խ;X�)�^zS���j���a���o�:Y��1����XPIjʽ�V>���鶣�YH�ϋd�.��/���/^�5�S�ImE���"�M����'O�5��M5��*אD<V�K�$�%"q6�5�Y8�Q�G]��=���u&`�f�!a�=h��2�2����>��2|-GUd�!�T9�U`�v�@���fj/� ���!�'q�0�|�\]5�]����g݃�1�~�]���a�-���o�؉�_u����H&6�X�m����F�6�LJ����tЅc�n�
}i��+6�
=e6���Yl��`$���lP�M�9���BT"�T�ԨB�D���<�B�0��<o�>&������M��|h�~�И��:�LS����hO~��Qm�	uı�"�z�$��#~9�s}�RR��8]�7��׶��rCښ��
�P���� ��ny���.q$y,7\I�	w�����~����l��k��M肩;(Qh"���d| b���ku�=� �����#{F�c뒏1�\��ɒ�E!x["�çg�x0��?Z-o;ͩd��j�xt��g��).\�����!e$s#/-k]F*J}4�*l΄F�w�B=+5��w�t�������.���4��������8������fs��cɜYF�Vj��I;*LFy����û��k��}�t�*�����0��^�ک���f��}h��Ed_ 
(���6��];����\���~ZxB�66�p�9&�������?�����N|PU��c�ѫ|U`��=+��<8�������e��ӡ�q���'>���<=At+�*H퟼��?v�>;9@o ��7uj����$Tk�,I��`���fjn�O�N�n��V��ȑV|�R�4�u�	���>�>ݍ��Nؤf�K�p���dx��K��
�~I{�8�#��IRzԥRo��`�݋H�}��kZX������S)a7��r�����6�����R��6���Y'Ec~��BP,�gKA�
�%�r!����m������v�NX,���$�,	��<���Hb���v�L�E�t��T�`�;4�C�Mç��S 4�7.�	IAb~������7+�5C�~l]�QHJ��G;�`�@����Q��O)fDԠ"M�����p.[���,T{������s���k�:�_2Ĺ��x��c&��#�#��1ܴ�ŝ�e���H4|�$#^�}��VR->	��4VB6Ka�\?5��(����5�*Q�#��aP̃%�p
k�:�Ÿ� ��c����������t��[���p�de���F΢��IHۍD,��v���v�mB1G�10R��ȓӓ�M�us��Ti��qJ\A���ms#r%�V��"�L�C]]X�?Z�xi���j���qΥx��Vp����I���}�V"q�ǚ�a_�H�k��(U]��$���J�U�)5�"բhV�n�4|�D�h<�hI��p��|���o����Y�9K���T���e�iX2]¬���E
�$�� {�#�2�{-4���^����z��tJ{ B��:锎;�j-VU��8~���i;5�K�
��5*�TnG_q���x�}�����nH���f,��m��S����?�jj9�>��m�g3+����.��L>'��_������a[��z�RmK�%Iڗg�4�G���>X�A��gɏ>�(}jj��T�E.C�)a,pcl�<�pҶStq�>4������9a_^ISuJ��..�T��s�x������-��p0�}_D�pH/���g@/���A�(�KM*έF�S0O��ơ�^7���=6Q�,*E���3>�D�Ju�uy����W��H����_�vs��LN��*IA�;������
פ�	(NA
&�JF�M����8'�����}�Pp].�M�dQa>ǌ^h~Ƈ.�V�R�V̊t�(6���n{��Xa��igiQ�A�X�ڼ+8{�C�ȱ-����3q��`-����ڵEK�%Au(���`���:#X<�^�˅S��2��}g'!,#~E���쓖ګ>�<�K��XC�mWe����˶Rf
�q�����A�����[�֑;W��8�m�D(P��UCs?����*"��f*�P���sÐ���eNk1)Bf�`�2������ϧ��:�B�	>�M��F%v�Z��y��׾�Z�t��J{�����t������)����㒅��Y(�Q�9������q�3�P���OW�%��ړ汝����W�����lz�ScA��y��e�J��9~�����s�� �1�̅z���x��� ;���+�г�g�I;��}�yd���G����_kq�cx���@��_��/�����Mk*d�0�X�-E�R�a?����$W����^?�_�;aG$��i�RE��*R��_����]P�!x���R��p��y�n_F��UO!CRH�Bp���J�����O�k8���)OH�(Y���֙c�5lM�9/����Ҋ@FSWdc2 ��aKz��>������f��k�Y�F��w��� N�}�N�f˅�};�S�K�_Z�9����|r?�p7.�w�v��s��q+7ﹰ���㗿u��ZO�Te%��k�nʓ�K�<JT~�����Q{E�������P#�tq�+��k�1�򷇦������q�;ZN�ڏ�t�e&w�O�^z�WH�4gQj&�:Y�5� $lEH��׮��]�Y<�_6����TػA��a�埇5n^���3�����b�G�r�\���[�([Y��r�z��a(_��5	p/�aI�|�$/<(^4����Z2�2��ԇj)b�Q�h���]i��a��4���) x׆��,Jqiq���{k�õ�p%b)���=pQ"����p�ە���/���6��X������/�w���M���UQ3#���}�O�x`}O�H��Q�����t˞��!)8�%�hj��(��{OʝFo�Ͷ�[+��N���VEN���U���?6�u��4t܌��ݗ�d��+�B�i@@Z�]&����k'��r��09���4�0R����:�Ao��n��80�2��(R8�^��0`�0թ��O�j�E����zG����$�n��F�P=�ln?�����şJ�=�s��:��(6�oA��hɾVLj�.37bj���s1д�a�1w g�6��U�Z�F��E�~y�o���6��;��O�R���Q*�u!p�I�c��A7�ϩM-E$'܇��:�T瞃�Yea�O�$6X���)i',k>����)	a��w�j"x.�    �kDJ�*��-z� V�Nws��9�7~��@���\J�&z�_����h)��Jۊ�j�j��dt�>+��dRa�ǜ:�[�q�䙏ʻ�������v�X0r�mMqr7���.Y+�/�f��e7m���Ǿ��xcAI��˷:R�LX�3�΋�A��[L�9�!�.΃����>��˯_~m~i���צ��֦��G+X]��"<�FpŪ"+����_��n��ƾ�S'�,X��i�kB��4�v�L��p	i9�Y鄸�/�fT�����uUT%R!,V�J�I.�<��?�g�u�|�������:k /��K�:�$UN��x����O�|��f�������7����dm�瀓Tx�����о��������Ut�Fo�i�
�.�*�q_=�� �c�N�)
����{?������~��HBZ���	�ZD��S�	}��ah�ӥ�8��c{�A�F&�����fq8��?v}��K�bq�}�AOOH�8�gR���Ѹ�fãP�x�ME��]��r�}s��f;�9���`�ckoM�[re�j��W�B�#�r܃���M0��n�o��xZ|���hNJ�H��N�&C6��S�����m���"M��	HN� |����j;N]�w<ٕ�����<O�VL���h$���D���=P�Io��-b�bۊ�K���[��+���]��H�s#��k�h�J30I��
��d�N(3I�^� �aUi[l�̩J��P݃�(>,'�������+'S7\��dm
I�L>�Gx�Z~�Ccmd�]ULֲ͝�*�a��3�E�&��J��_�f�%�7��]3�_.cE�� @y��R�Yu����K����B3���<�,:�$'��ZK���ZcbQj.�јP��	�����\Q��+�IYc`-����^�Cs�"�`�>��T߈�0�	����\��.z�K��{y����sN�FO"Ni��@�3�h޼|���N���)��L��d<�"T����o��������|�.�.��
�3���/�&t�,,���X�GV֎d/����eMv��H�Ϛ�gooL1	�H��o*��Fv�_Y���/�0^}���c:Z����lJ�ٚY���a���>D/A]6R*6kY\����S�iL�����[�NjW��b�d�ah�TX%�V�{]J�{3��Vd0�/)7<Y�OVzj?��D�K�uS��%��Xe呌\E�&]��޵77ܰ4��ev7��1�e��P";Ld�`����&�l�
�Q�k�)���O�\0�h��X��V�4(��|+��{U�Ϸ
ũ}�L�^����^��@��f�?���E�c7�9�]�Ǌͨ�L�L;����I�O����D�Т�R�WM�gͿ2��(�	�����7Ctz���{����7�'9��S���۶��6��ս
��g	�{xu3'������}��k��ij\���cL�����@�Fɪx8[�!� :������qb��_Q�����VѭH��gH�/�S����yw?޴֌�uɈ���4�	y�	AG�@�A�xÜ�<D�Q��MA���u}�&���\�
<`�O�� �a�'�o>5W**�v���g���hK�qm�xù罧���E+�vQ&��bQ��I�ԅ�_L[k�+"�z&T��h���wLy�E0��"��3���oɟ���j7�1z�����8��aO���R1�A��]^�ôڹ뛉�ms��Uǭ2��M�Ë��OS�]ߵV%$ %!>1�\/���<��#��a��6���t�����D\&۽2w!����ľf`�d���Û�"P��MF6���M���7��Cq���2���	AM)/P	��8om�Zy���D<�_q��z�W���~�ij��,+�I���sQcf{��G���!+��K���p�&�+m�����4�1�E�
DO�ϾUXo�jU��hS�pw`yF  ��5�*�%��*=��]_4�56�+qG���(����^|���8�#�Y�g)Y�l�y�����m�W�v?�=�ʍ_*��﹟[j(ЩR����aK�Y��JW�kF��H����<�%��4<*��6�e��˩yh�a�y��n�k�?�ZIbiJ-U�ĤֆJ$m1�q��>Ò�.6�X �+d���+�	��t���L�fs��8�f��Tb����e�n������=ac~�$]6��S~���%:6w�\.Ux:���0������/#���w�<�������������w��4�1�fI_b=JVBw�f��ڸ�QL���5���Nj�INmZ�)N��A�L�,p0=SB��V8�hx�E�y���Oy9+����3gg����M���tm_�3�f�%�HFr-���⛾�� �"�Xǽ�!3�K�Tc�C�)e ��f!	q���B�'1b3�mp��  ����^���XL�/t�`rB� dGѠI��$-N|dp$���ѳ��̂U�����o�I<"�\�؂��Z���ZY�� nbQ�웁k,��]�
,��\�}�Y`��s�eݔ���kU�99/RɥM���dص�P��s;t0`���m�C5{[�0�.�!Hg[!�Y}Z/�H�KO�]=�/��f���b�3�*�|�)O��}��+e�X�7w���:�sF�Y�4���ܤ�z���`W����E��X��`$O<���#nM��#I�Es�L�Mtrb�p��̢Q��Z�oKҸ�����sUH�.�~�VN�Rc�R�A	����M���}�~��ks]|�����d��/0�P̤h.����q�e��q`�F����K�<I�""�j�[Ν^�=�^����E%[P)bu���ku�J�CzA*ku7c�Fc��3Y�GLK��3���e��宏N��?'+/A�zN���Ub���;��-o�{xK"k���a�b
���h�V���&e�p�/��2p�.�x��,,�-�$x��d�#���� ��4�L�do���~X����\�^Z'J��pg�y���D'8��j���Xs^j�j�sh�eqy:��4�H`-M�"� :S�Z
Փb!�K�q�u��p�[���{��/�)h񂩠RU��� qx��{	�d7mTe͉D
ɥ��b]�hɱ,p���\~������b7n�u^X�햄����4�(��ʁ�*�Q�żKWt�*�_A���<�}8Z���S!
��
��⠽٧[�}D�8>���A)�Z�&��i|
hitW*pn��B���"��4�}]�ާ?��d++�� K+��\�Ob;HB�g�9���l��Ɉ���l�~���mp�r��8�ȱCJrz)��W�<����-t�e��p�`�4�_2܈-1��rh��hl����`���Bǟ��FS,
<���}���f���NϷY!k������p��C���%dAD,V{����9�'�5��"cH�2w�`.2�"�/i���_e��'������r~��nR\�YQ�E2�ȀA�*�.����*��C3��٭���ihc�WZq�&�U8�qKq$�����n9�I?nƾY�]@<W;��J��vQ2y['S���9��a���� ����(
Q��u�|�dX.��I���^*oo�����Cd2?9"��4c�G�8Ll��6��Q:��:Ti68nM�	w^i�h����z�2������Y'Q*,e��<�n�a�0�n9�&���h)ŕ1�UNW�Ԉ�%�"6�P����T��w�Ș��t��)ݠ����vjZ^R�8�K3���R�e�v���Jؒ2�G��+/1.#��_o۵}s`�d��q��̆a	{aKPfv����]�u`X�
(��Ѩ�/��y���Ls���"�B�'^x��S{u�k���c������7ᬚ[�:��2�F�p-�{�ښ��A��v����{��~�j8���SP֯���m{]l���:b�jj>u�a�)G^�+�4/p68�����Gp�R��wʡS�pxb����p^�ߊG97��{�@U	O�B}&�y9�m0��S����}���-�P2����m�I֍��+Mϴ    �2,Qy��Y[�xr�V���\�(�{��2�Q��q����?���j��1�R\��YR�/�⟫�ݦrɽ\�R�Kӭ����N��v��Kf]�lÛԚ�:�E�\�,$.���W�T�a�'*1P��o��J4nn�i�`Uϩ^e2�N����͂X.���6:�6���uͲ�� E4`z�����il��J�M�?FB0�'ށ&K��B�(��ޔ��rt��L�k�#��1:����Yt��X#�sU�����I��N�wrxI�֦�(��* �+������J��+X���J4�z'����i��5eF�]��1֔V+���2L^a��:2F�Cx����� F��n7�R��2żZO��	�T,H^4O�ŉZ��ދ��ARU"B{�+E��Ԅj,Pd��}������Ǵ��lyMzrCo�n�i��[�e��
qIz)�g_q���,nѯ�c@�����^0`dj��9U#y')Ғ֊�ը0��i:pP�l��]��K��7 s�=]��@b��~��Ԛ.�FC*�3}����x����2/�T�-H+b��\�8r�T�Ր�����3偱�=N�&�p��6�6�y�pqvR�K-�?�zk��	�Ѯ��c����E=t�#Y�OӀ��d���YjY30��c�з�]т�g��YCRx� *h�g�К��.�cr՚S*��g趹!��;�uaY�����M�X�l�	u@O��1����z��h5�|��~?
�ڊ�I�F�� <u�zUr���Wh�U�����A���i{'�ܔ�'Ԡ	����8o&�L�:�,�	�3G����@[��T#�ȯo㹷���><vyF� l9d��J����u�ԫY�� �䣚'@ X`�=ݵ�
��q�p��S�Sn��(5��!=����Dn$�t��S�Bf��������S,64�bC�������jj�b�\��e�Mm��Ժuj�&�"3�h���Bx�WzM0�|hh2�`�� /��N�bX��?H2k��r���@����Jj���+98%�/���`g�*3Q���4H��`�f����[�I՛��p�	��w��f�eM^e�4�tp��v������:u>Ֆ���n7��o� 2ά�A�-����I��$V��Ζ�|��2�9j�,��u&�I,c�ƦŠ��$�����k�J�m� ��On��˞�����/����W� ��v�=�jm�0��	�ܴ�܈�Y;��Wbmk��D�*ԅ�O�v�I�������	5Ц,���2o���:@S`@���4r]bo��)U�<�dp(x!l_y�)��D����L<G�sڡpxm5�0����wp����`U��7��B���JS�H�!�e����*��ᄎ{�FxK*�Q��#o������~kh;[�j�'3������Z�an�91ͨNմ'Y��˞�4{�y�J1
W�C`Vg��X�m�c���i��ɶ�j7�v��5�1D>�nf�y*r����hy��1u��^ ����Vy���� �د�Djc:�.�~')?��C�7MJ���g��.����8\�Ctލ��*��Q��ZI(�����1z7^���u�)�J-/�Q��V�涛������_�؏��9�Tۏ�V��|�0y�?�cL��A�"�Yٜ�,�h�j��E�b���>1��2"�_Dr�SQ���5��>��*,`EDS��x�
�O<.n�_~�ڞ���dKH�x%��������߅�q��5���X�J>4J4n�����4���c��F5lArۢ��VOQUTy`u!���<�����D3L\�&kB0�r��}&�q�b�_��R�&JI�C������qH!␚�S0܊�)y�~��o���M߮�3JJbUcLI�	�%�,뚘8�f6��0�uMڸ�S�"<;�����>6��:S�x�U��MM;Hc�B���tX�4uN�R�|a� �@^�J<7�r���b���sT�B�3�d��^�L+x6`N<ѫ �%�q 	.��|	�kr9ޒb��fw����حqC����#6yT��Y��''|a���2�)4���m����1���N$o4i�~r6u���Fh���N�F�F���{��%�n����`ӆ�S>�	�|�Z����88L	����b�u9P^4�iT�I@�F)k=�XG'Pq%^��Bm�]�JT#z�F�3��$�9�`-14� ??�۔��oMs\$̈�ܧ�ʤ(J,��F�7��]��U7l�pJ ������C�����&\@�)Z�5M夑�h���}�f�W#�!�����Hj�"{�Hp0ȇ ќF����8E��l�K����T�Ǡ9P.��,�@ �S���&�-(�����T�м��4:k��!��p���0]%fg�c?�w,RCȚ��4�"�sT!0� �v�w]03$��UĭCU���;�8{�7W�GE�G��w%k�G� �K�pFf����r�%e���ͬ�<h�xP��A�Q%�4J<Ҳ �����,fI�k��'���P����w�������e3����c"L��r��� #`_������;U U�<�����m9�n�Fo[��o.w��Z &c|%]��IJ�C�.']��L�U�nмw�R��
���V�=h+H�O,xl��
�ǲ����X�L=dMG-���?�i��6U���%�Z�N��-�A���XdIT�x��!&np��{NZ:X�g%�=���m��n�tq��<ybE匥�M\�BK�P4������\��ɸ�v_���-g,��9q-Da��W��9�0�?�\�yjm;�4m.��ap��>������f��kk����*9�@XiЊ����Yt:=�C}zh?]���=MÞօv��>��e9M �:�:���<�Nک�˷�oc�SUє�o!^�re��D���͟wBoV+�J�y97'f]h�{H�/D?��e�1���.��z3͛Go�ܱ!I!g�ah��U�,�J,J=4}?v��U���c�P��XY\���D��|�B]L!iZ�K����릩5A8��B@8�\��Rc(V88�?w}�Q���o��z��u	��&EfHH�|U��c��|��i4��i��T^FQ����^�ܡL#�A�7`p<�q����}��.�ah��j)�&W�D=��pd��zz;���Њ)M+ͤ�i7���$ay~q�*:o���m�5���K.��k���nWPmZ���@�e{��V�VyDS�K!����S���pG�鷻ᮝxܺW�2�0��6aXO٪$B�ގݶ��J)1U!���_շѻ��&4�ه)���_S!4EN�q2����]d&�A5R����@����غ�������^=z�%I��R�w��"�LP�z�՞P(��� _�ɐ8�������;�c7�ۃu�Z�h2��LU�*�Ղw���N��[l[�Z���߄)���f�������7`[?�t cb�w�y�
q`��r��0\ş��)��C���B m1@?�S�O��ԓ��?�R��Q��<.5��ϻ��ݘ���?|yر����
���*�ZQ�]t�T�P�����Lp�x���ep���
 *�ħ�)����{��*+^�!���n��e�R�j�:��ɲr(�T��;��Sq���	h�w�Ä���vj6������W�,x���xI�'���/�`�eHE)c1i���RW*��lji�����^=�|�*���"�G�Z�hFC��,��
� L��M�i7�ӼĢų�_����Go��o����l�1z?N�0���v�gkϹA���JӶfr!wR}��������������5pVyݾ>V֚�݂4#xdv��ܵ��?6��w�J{�$"��Qs�4!�U��?\�!z��o��.8��Q6�$��*�bLQ���)uր�9�᳷p �3'����r�W��l�@��9˓
[|�?mwףC�d����j����ݴ�8V6�c�)��@�b��2"V.���ݴ�Au���U~zֳm��S�yU�a����ػ�
Y�,�Ar�t+���Xo"�    +)H(N�j��s�gLˏ�cJϪX52H^�ƨ\C�}l'�7寀P�i4p4@���.�xa��O�n�-�N���A�Q��y��|�o���HE�7{cCߦJZX��ڤg�bCaf2/����Leh� #-�}���G(�� �j����&e�0�J��Je�F�c�����aY��<�([K�x��饠z3���)\�)T�v��@\o �bįM�i�ל�Ͽ4)��aq)�H.��%eL�R���/<�ɺ�d�{�53��Q����E.U@\|�K��K����C�/�cz�~T@N����p��8����>���U"ᇊe���Ϻ�Y8#�)�].ɒ��j�l�T���.Z����s"ΥМ@���(ɥJH�0]|��۔�y?��7�f�%����22A�$,;�ͻ��3�сZ���H6�VE����.�Vҁ�2�:�Ϟ���QAeJW�������&�����0��5�]�w��i�/TĳG�BK�-`��cw,=қ���2�i�Ԣd%MZ��O�s�J�$�7���`��]j*��u]����*]������9��>��+0�-�"7�P�mNjx��&�d�8���m��(���<�H4�.��g��=Q�'΍8��k�(Ē�kh�l�s�Mu�!�7j�������O�)y��)�ϘӤ�q���v@d��s2�ڕ���0����K�x�ʉ�{�Ĩ�c,F(?�P���4_)�سVrM4��5T���@�
(I
��_(�6�^��������P���ª0�Lr͒��t<;����Zt9��%܋�����K+1r.oV�<�T��c" ��<�~;u�㴹�C�Ya[k"e�ޗ�J$Cl}v���jo�A��dY.�ʌ�"|�����cZ
�b.L���5�j"}�o�gG�7�um�9�7���7��Wo�nXX,[a?�R�HY�r>UR*~n��I��P���u�ũ�����p�ŒǑ���,�� ����Z(E{͓�m#��?5A{9�H�;C����d�,s�e
��*�7r�L0� �����Zs�OdP%�չw��"X0U�)�]w�*�z��w���a܄da� F���\��\+��z�e)�H���kUF�Reؽ��P������\��j����D�t��h���^�S��o�%�,o��}���K*_�����|�).O�|M/ܤ̾��"]��Y�E�1�U:��WTb��h�a�{��|Ea�B�#��-�6���C%�h9�?B8�(�X~���;�4S�]��З׏��X�lz}��%��9��38j⎄c���a}�L±
|I��;�S��k��+p�x]Sav�HQ�:�]ɋ2�3�?�U#l�>b��ɥ��*�D��KV�b�;(%���Xb���R)�uҒᑩ�����~���f+ҹn���n��h'k��Y@��-����)Ԙ�-�80/�?<�N�n6������`X"0�W9��Tc�ґ^����f��a|�6z{;�C��`D�)2��a���;�� 0)���s���L�6w�QH���S�:L�p1хϒe~�9���e�=����ZD��''I%_�a�B�%������
ʬ�$�i0a"��u�2���5<מ�6%e@D|�%< E�0���@q,i �v;?l��`a~ � R������{Ij��aH�Ǻ�^��><����45�w�ǻU�+&�3(-�j��n����ע�5aq_�q����X��S�x�������>Fg�p�.,��\HbCX*Ys�+,y�%+<�d�4x>��1�w>�A.8��$�.�Ftu&P1�Ȳ!���N��8O⒪��i�}6�����O��]��oxL��[�R��9v��	�:��+ZDq�!v���f�7\��ˊAm�=1�*d��7�N�3��
SC��q�f�>��S�,.����hܬ�D�!���V�]ثQe%�4���6��)�`�C���o?}��;k�w1�&֗���]��E^�P�a������n�������87j
a8�B����$H�'� λv{�\�}Nt�Z�p^L�e��=�,s���c�96��`� �2�R(^���㗿uV��j�H�b���&X��+��(�4o��pŔ���~b
�D���P!�d/�g�@&����_�f�w�?�������H�Qވ�Y��£n�9K.��v�(*[�3,n;=�l6s5TDF�	��¼���%�J�*��DٓS:3��ӎ��Xɉ����+�f&L>
X�K�O�`V̨�( �Xג4dF(�qFa�(���(`A_l.^�m��ƕo��t�P0�Ȏ2�[x����Yt�N}7����4D�>�u��m�����Rk,��2���:0KK�V8Sv�����l.w��iJZW
��,)5�4C���!�����V��JB����+�KI\B���u2���c��S`Pp0�ȃ�a����ϹL-���&n��a��$�ceD�i8<6fB����B��O��b_��������P<�S���N��MUL����s���� ��!�*Qx�m�m��u��c�aHp����g��'U����k?��-C6�n{�"v��0�̣�4A�?�|�������w�톛֎9�+�s�Ϲ�u]���C����3yI�@p^�u��"��S�.V���LcCja6�F��#���+���Mf��"�_ *�����O�姇p��f�ۀ$�!0�J�IR�pK��b�<��/�9�:��֤#/��-�+'cE�~׊,��U45Qi�p6�tj�~s�v��+t!^�4$L����`�dIZj�m�����̭cHM�_�9{B9����e�-������c�٦�	�e����oĦ���+�"q�C�d�6������+n�:[
 �3����=WG8�����$Dd�x+��,"N�-�e7-���/[�b�q.a��Y"O���EW�q�8��9!ҩ+��3��-	���*g�/WR~D��`a9,qs+�L'n���hgny�|I���ą?�e"$��"Ir���򼘚��ݴ�.�9kc�D��'��=�h���w�I8ajn���	�,ܢ�e+v�p�N;��h�X�;�$��L�K�W��Ɍ.��bj���F$�Cb���l�����v������A*F:�r�t���.��A2��d�L���Z�drI�;��Yy?~\��m�_��mH�8py����"Gw$�25kL����5	q�\��NQ�m�r�L�_
�w�eq/w��RHЕȖ,�j"��D4Rҽ{1$�/[ց�'� Rh� *�����j�)K�3�R�u6��F�9�^$	�̀l�vZ�8��T����;~n��gʇ��z�4J�F�W5�ǁ�c��q��',�\�����%��8����*ۛ��i@$�ܥ&��+0,N�"�K7�0���[����P<����6ѷS�e��ib�)�e��Z�$mIL��>�>:�ߑ��v�o7����-�J��H)�ʖv4�N��.O~j6�܎nG�A��mw�Y�V�@
ߌb���Z��������Df�(|��Li��
�S��TwkxF�����Z�ʲ̐�B6��&� � �	��k�&z�r�b�Ĕ�#����^��P����8�E�8��+j�S�
FZi(U��T-7��^��y��������v6�J0J��;�D���ʃ�t��w*�mt�,�m0$(���t�H������8Ss�v#�*S����@�d��	�b���Xjյ��PRV��#�T0�]�Llq���p0���q�6�m�F�q�_�ܕ.�Ԓ|�Ddmؼ^�%8�˳Z�=?����-�_��,�d��J��'�'˼%lJ������Ob��9�Q�2�
���Y�l�a	�j����g*!���M�ǳI��+Ҷأ)a#��lL�Q�6��^�Z���[�t��nԚ>ܙf��e�^�r�cF��$����W�@"�RH�����"i7[z#���$��\�+�+�"��c=�p5��qNwP�6���L�@d%    ǟy$�V�=
<��ӝ�$��:��e=�i-�Hl)�q6�m�;p1kNa�&� *�?J뎝�d������-����&�	Ô)>�D���hK,W��UL���f4ʆ$-����5ۚ�����x6�d_� �����^�������]��?Eg�5��>,�[�b�-���sXr?�|D���n�o!/̩;��5�-p���x�H=�A3�.�}�x\>_lh+ �qy(���d�<���ss�L�*�<AY��
	N�ݾ-x2�/����f���������!���b�@�+
E""#�Ub�rz�L��ݶ�w�4Xo�����FJ�D_�F�m�W����n���O����������YU��6^��x��9Q�Oݧf��ä��$s�0��:�$��}�9���$^�)ePƒ����`;�+1���w�w<�G�6 0�mo��	!O�_�}��麍~��:�I�8m�#~��o��D�J��f���R�p]��#2a�ςU��h��2�	+Ί��ʾZ����x֓,��<
V����Ctdaeu-����(�e�!>ed]�h��C>�x�?<l/]�'���w͇�8y�1��W��m)��M��Ł�Gc_�N�JB�J��+�Q=q�Ƚ�pY�;�Wfp÷kڼ0�:��q,���y8��@?.|-�-���z�{�ߏN��Sk�UIԊ'��SI�p��W��a���E]�7�1������ �{�c�w�՝[)m&RF�B�hlh�f����|�0I�zws�"ɽHp�cm�MiFDX(CL.�!z����m�9�QR���hV\c�X
���ɮ�EU�oZ4���C�w������#*E2����XТ�RST���ėdG���&>QCgo����B�x��$s���f����v�?��C�GN[�r����,�BN�p陼;�g�X�YRr��!K��Ps��t��q������	����`Vb��KE�efҺ����TBuAN%�R)Ԍ ��͊���mn�?6�>�4of1�e/�%��{E��kW݉�Ӿ���ɍӣJ�h�A�`�*Ȍ�w�V`Z�c�c�:��/�8�nLT��V���*��ĽҔ��%�/_.�jpX�GKW��WգL���,S�}��Y]8�Λ�=�ձ��4�.�Z$-�J�B��J*0Z������$�nZt����v�C���z�&6Yhq�n�����4S=��(Ǒ��0&Q}�#��&4|m��zba��ۮo����m�De13�Nc���v�R�5��T�G,9��GS�� ���A�Vw��e��`�����ک��Vb���������]�܎�Mt�m������ܳ^�`Qo���Es5�o��ԥ�5�qLIm���s�t�9��=��_�Ŷ�r�LS'�:�󻥡58��m�I�Sa�7Y���Kk77�3#g�lp�+�&8r�ԟ�dsa���3�݋eF�E�b~�!�V������h~�5�Yn{�Õ�TjD�:����J1��'�	�Z,�������r���@4�����>(̊�� ��:����G%�65�69�D��Y�"����W�$����_�ʺvO*F����IM4�(��` h�`RhE�:r����|FP^�&��P�J�v�I���$#ޥ]�Huh������o�J{i�(����ூ�	���N4΂%��-s6,=�!�DCV�x�!���j��@Q��[�jxhO�mY`:6����c�C�V
�B7|:P֎[�3d�,��
x�S�_'l��DCت\%�T5��q��xh�q�qQ!ơ,����,��$�,>R9��R�{E�u�yu������Ԇ���<�����츚�%`��֐浌��������c��s,\��kd�UU�j�� <�"��g�_��s�I�S=\�*�D�j���XES�x*��ɦ�c��k��dw����s����*�jf��)YcN�=Z���޻�W�UM!*T_�cI^���3q��T����H����ἆʞ�j1���r)[�3<����{Z鸼E����aJ9E.s<|cGI:�Qū� ��	�9R-�g�z�PZ_PjZ��yC�V^f�Q�x܎���b���51�0?=�V�4=�z`ъ������?��c`�*:�>T�sn���Ż��s0-�f��f�Do[�Y������C5G�1Y���*���rc����V���j��L�Kp-l�O8�*wd��0��j�xD���%��i��R��R^5�	+d�A�qG�-2�W`p�^�y K�g���{��qS��@���L��E��y����e㸧�uO��#3�&.C�){�8����d�x9ѓ���V�
M���+/�����/��^�쯳���k�˼*CT\��ƿ	��a�����A����=bR�♓�R�#�D��D`�����.��7�8�O8�@���:�|�~A��R+҇ۋ��:M=z���wz�Np���Ww�L��sD�+M��u�@)�hU�ǹR���/R��Z��}�cUs.�b�f�.�c���6�� FS%9��X�<n��RI&GV��0X��N���[�y���]��|�N'<hr�:�9�RHr����hǍ��j}�h8�	̖�\�]�8�m��`�̏^������}�a�^�-��_;�i��c��1��"��S�x��s�U��~����r��)C�$�ef�����!̼S�c>,/q`"X#bq*�)*L�
�	焉�UkV,���j%��`�������_����28�K�VU���7-��w���y��L�.T}TH1w	n]�]����r\q$W>����?�w��	Ol�Q~���m��j{d"h�-��UtSv)�M:�̯;~\�UYʽ4�ҋ�LȺ�:�Rj"D��;dD�X0b��[>�sg��_���������B�|��m��D=.�O����<��絲��Tj��V,F�(��w4q�R�ֆ%he�oho�e!*����]mH��Q�K-wCΖ�x��T3�����na���|� �t>���X��)'kpc4����������ؙ�gĘ+U��E�c%��ۢ���v�,�2G�<NĎ+�"��	�����v\���I�Uq��2��P����5Vu4F�ʊr��(1�B�p�p�
ke�bՃ�Md(d��J��u��F�'��j ��U��Ց�vV��e��p ʔG��qUI�U��FE����
�ޠX�դ���"x�gXA�I���VF6�}�y1O?�BzT"�q�Տe�ŝ��X�bBfH�g�$A8�SKN�`��K��^�H�"K���I��Y���v������۸��y) y&v��W�!ƿ�0��i�q���������~���m���f$�Gb��j������T�$u������A�u��i��5��x��#Uއ(�4�-ߥ�p(�M�0��8J��@}qI����Ϸ�:���\�n6����o>rU����Ij��p�v\]n�o՜���w�c�G/��ۭ�g�f�2�I[�f5�2y�)���n����*X�r�h+>/���q;����x���֤1.ã��t;�s�g��w�9X�eK*�I��Tln�х�u��)l"�M��mG��P۔�Rn�W�p�>���(%(8´��L=�'O�œ��:���O/�G����M!�VFozҶ3�B�����n��ys�b����	�2�=��#�%�K�*9��D@'%�}w��ɽr��J]� ˇ[�-���	a�p.+uC<�Kj�o�?�aR��0���'�)��O8B0����ڗ�@�0�h�o��23���<��/hTqIT-�\J�b���k�F�n{�N�T��"�Ԗ�؈hR�Ud	�������!l+�Gbҵ[�t�EG[���
X�QtJ�>g�W�˗o���2Uɬ�MƋ�T%5��
�x?u�|"�?�9Dn��ፒ��/_a��Ǯ���8q�i6�c�0[xRM�rM�f�wC��?�<mvѷSs���M KYS�NL;g��	dPhk^��u;D�f�������*�҂k�ΧW�$�J`�1M�w@kL>*�r�<C�Eϱ�
sʽ��5��$�� �  ��Q�x|����&��7�:��}2�h���V���l��b���]�d��1��ʳF>xI�#���W������	mD8������w��qKF#K�qNu�lo��F��%�x�W���RZ���\%�s�r�0lC�����
k\�.�6\~
� ��ߚ�:�#�E��_����7o�u	X��$��pO�xˊ|�~瓋�������RBܱ�5�$�#��k��Z�e]u2o�T��)�zS�P9`̡�a�.��.7�eh�le�٩窑3pN�3�v�kc�\�ڊ�q�jT����8�)����Jz �ը������ewY"�J��5hC����G['h���	�+#�&�q&�f-rIr/�<��gt�m��r�����sS�!Ln{�T�K�l�̂//R^�)y����\��.z���g���?�蚫q��jγ���qE*�xE"d�����~C��      "      x��}Kod�u�^��CL3��l>�d��d��d�4�]hm�����h޼����W�=�Y�K���%R��1��zkUj̮U���`��g�yE܈��d���F����ƍ8q��<��ӳ�����մ�e���=��Z���dv��*w������쥓�u�3t�D���j�m)L�/,��Q��L�lo��u�����X�������������Vf��*]�/;ߪl�*���r��C]^����L���[����R�����LMl�
%k�5׻b�s�)ݰ��Ir͕.�E�r��?큹4��NL^����>8�a�&� U9�w�6��p�o��W�S3�����f���n2������Vce�h\���I)��h}7�ز�i�B=З�
{	S�]���n����q��i2C�	�4��ʘ\�ǫ<e+es�B���k*u1Q嬬̤+���qkpQiؤ��/���&���cm�Nt Q��AES����ոD�k��������6�[]������5^�_��g�(�XT9��������wU=�����{]F���g��T���J[Vt��=^p2�P]�-,E�
,����(3�-��~�Go4�X��o�����7N�0�6F�����p�	�դ�*�:3��/�mʱ��<֕+����������$G�w6A <.���s��csW.�/;\�Vw���
��0CSL'9��=t�=G��~�M���h�'S`O$d�K���v}Z���
�%KBL`9^ʚzZ��E�#;<y[�BϺ���ї����/�I\��ҥRl-�����À������_�����VUNa��� F+�eR:�@QR���Q�t؂���P������}�"�u�<Z>,�?��I���S��#��W@��O��~�z@y��gunD2�(`,<�#3e�5��'T�Q������L\��s��SS�m"VphPF%���e�(�k��4��d?�8��M�o�@�l�yÍ:Y�,A�#��M�}J�q��.�)�g��S��H�~�3���>�����ࣳp���I��@�eg�G�o�<]W�J�����X����v���Z+(����3S!���2������B��.iU&B	Rye�%��~��r��|�H2Bό��&^���Q�J m�����X^}p��PM��]����R��I�*i}�s}?����2w��A��X�#l�g��T��y!=Ig�jxY%�6Ys��<(EK�|ti'S�̱Jj�$���ar�Dt�	|��-ȁ����|Rɲ]�H�#�d2���ʑ���P;%�h�xs��c}i��*�@��/G�cO��������0��x��Z��� \���: i�	e#��t!݄5q��x�w_�싟顾��5v ���ɱ�p�C�W�`�2�#{ꑅV����m!�|��jwk��A1��ZPVǧ�(��� �}�Rp�_}V~�6A�����Q��{Ԋ��
s�(������)��g�� ��r�Uw��Sw:]V�A>�pʝcͳ�~G����-M�
h��T��Q�,��6�hD��˩��c�������0�=��X@���~߷�>�q!x=-��26�[p�@����5de ��G����0�����\�=T���OI-�<�`;���T�|0���z�r��9����!�86��S�q^L�*/�������z^��8�����VU�{��	7����D�l��J�$�K�Mf:1���l�D�3�a�e�@�z��(.;B�$���)��qR����J��� �'�
�� c+O�x�I�jT�(qP�!�3�17%&&�#�"Y�r||�Il#f}���;���W8d=0l���i���*l����[�D��%�kQ�U!D!����MZޜf�[�� ���iM;V�?� g5L�Pϳ�>�fVG0"�FC]�+���[�G��w��4�>�}��a���RF����L�۵�ѧ$rDv���A:����._h�Dx����D7](=�_'���o���r�z0����V��2h�X�B�xqV l����T�o<�ƞ�:4t��@_�%����b�E��b~@d�'�M������sc,�5O��)�"�p��8�J���ޗ�b��<����Vh+�͔�tgpz��V[���_p���}O;у�h^ޚc��ҪXZmm�#��GG@�� ��YK�c���~l����bzg�LD����:�(��t�g�ŚG=jF ��J��HV9wA� ��r���3qR$+[��8ءe��[�����1,%)-(��R_)Gάh,��lӊ\n�4?�I�U]�W�f�*��W�e�᫟3�:�yǒ�VقB�Y��6"�E�U�O#��99;A�f��: 9O��8Iևs���	i�B|��B�}ꦤ��cA�j?r��rE6�
l��FW��������K�JD�9� m� �(Tw��@��W�vw�d~p��8�d�A��̏z��+Zsd�����,�F��t�ko�v5�.Z#O�B���|Q�	�Ʒ��U�'� �⛟���7���7?|��o~�����r[a����ĀAru��]�Kֺ���y��Lg�!�&����.�2���	/�v+p��_��rɛV�%l؉.f)����
^M� tE��q����hQ1=:���g�pł�'W��^"��=�-{�w�%k�3�p�~��ٛ���K��3���`|���w��;�	����诩I�GC2O`YOW�;�)�G�<��NMJ�7�m5n�%��^��'���-�7d^��΍{���e�/q����2:#(��{�C����� ���2�0��>F-J}������6�P��E�=L��	��͂�,�3,�Y��M{@��l���;m��0��UX���!����-����WȪp�J`FtD(�����֡%�%���+�~5��y{[��$�3/�0��Μ[�{���%a���T��-q	[zC�1?���� ��٬�j�A}����1kް�Lػllk�"�BY'[�4��b}�Z�# ���I�l�oҞx6��zz*֩�2�����}�u��ԣk�����y��Qt<A�G�*[6�f��SeU��	v�	P`	}	F̮�y��gС[)�@У�<��.�6�j�� �_b�9S��,�rO��[�x����"2]Дvd�; ��ܻ'�YK��-����:���;����\���[���e����)�!~Q��!O#�8k�$�ԢJ@�%�L���l���U���qg�[f�]�X�;��q1%�<4�����b��=4國�T�Ɔ��k�'ѹ������\���r���zlq��ec+v���==~�ߍ��N��y˶��J�0>�k��'>�j�F76�����=U�z��� `�(�e�@?�&H"�+��80Pc�G��:�1n��{���%�����Y����+;�i�}mAS����ѝ(e8J;)z�+dT��
@��壷�~K$��1���IO�o�@�
NVd�Up�Q��:@dQ��̇\Z�a�G�m�%�&��E�Cau��2ŀ�6�Ci��0d^Gd],���x��Q���+�BLWW0I�x��I���C/hp��Fn��Ŕ3���dE�u��G�$��m�\����MI4.�f�Or/�MWv�E^�ݼ��87',3�H�(���*��4 x�T�&s*��/]v	�kkS�I,򖖈�J�j�	����G��A��e�����f�	��s@�c@���(yQ���N�p�$u��2p"�jO�!&	Di��Ѳ%O�'��+h����l�(ٹFР�-�c3�36E���9+9ݱ?�g�ӗD8kC��U�������t��gY�`k���|��-y!�Ś6 h5��tg��#��ḃK�s�a�B{�.Dt3�5paa�&�T��t�n՜ '8Y��_����zCO�#x�Ttdʹ�Mr�d�&�L�12�@Ń<��d    ᮒ�����"!��:>�oLC��&y�q��a�-�2���cٲ��h	ef�;% �+��N�ȖC^���ȷG6��������9�@�#sX�@�
@�3X;�}+�^��D�g�j��@	�87ňv��Y�K�m� ����2�D3�N��Pq0��ﳟc���0l0���k�@�d*,�`P��E�x�� M�-��Ax�O/d��^oi�ʘ2(��*g�����S�DL�'�_����Ll�.2����"g}W�OZa���'ac 	����U:���䉈X6�!.я�[#�r���,�����#��$c'�'`��5,���!zvƶ�v9�l]�&&g�Sb���J�R��Z�f�O�9�%�e�3h���D:Ŵ1`��A��K�:����j���	��fIM�Lc��`�q���Af�W�����v6KG!��~�x
2�\
C=�����o�4
�È
�|:��o+�\+����Ꜳz�9u�I(7��Q���3���	�l��R���r8?:�ib)������q�.|ln.eC0�ˊ�	�`��!�I�>���R�����'ҿ���*M�p���G�!�\���j��e2�iL	�5�_z#r�A]�ıZyy�~���;�+���;P���C/����G����_�������U��	����V�������cN�ߋ�h^�wn@�"�W׍�Yh�'�H�;��H�#(&��{���bqƽ�TfY�בƬ����YV��(6�t��O���&�j.v���_���^Y�� s1y���9?Ҡ	׆��uI�]�|�
��ʍ��Iy�o�)c����:��]d���D^��/��acksi�pQ��� ��c	��v,�i����B�!V�U�C&��=1��k�<�Bˌ#)"~ll�|�ȕ���m�0�Tg-�Ȁ�ϣ��l�rv3J3=rS̷���f�fc6�٭v��� D�8bed�9�h+K�'[gA���'��B�:����y��(�행���;�6]���6����zXN��_ꥄ��)L�p�l��z.)Is��J
Y����)���;�Ϋ�e�|�������
�%��I�XN�c�7Qy�o`������O�g�@W�����}��J�а$�l��ӈ���ԬE��v�4��
�|��$����K�ks�%���p1|LLc����$�?�ZY]>j�^�eA/Z��0�$Ѡ	1#�Ov^�J�P^O�ĖS�q0cs�G�!jR���4~ɘ>���	=�rm��]�-/�7�UY��C3/:c}I`H��)E�-�K�����Z��&!~EVBGt���g(�[:������C�?�����ђ��J�5E#d32f����cH��]��4`�'��?�c��!���na���loW�c�,_�G�����8�3?����Є�� �y;f2�Z��O��
���͹[GU�5�u�w���%O>ˢ���G�`!�c.�GV��5����+��|�(�9����>� ��]�������1�=�Jh�\�BKt�,�O7(	tק���X2iu�c���BK[�X�c� ʚ׳�7녶g��.6@[��%ۡ�\��H��� �B]�� �9����v�V9�zbR4Iuy>sN�<:�EM��Q�}�v��O��M���B�ͅ�)�A��/ڙ*Q����b���yM�PԾ��z�癅�Z�X�V�ܕ�]>�R�b��.ա����v�$��լ|�F]^�U �6-e�?��nX�y9��e"00���T��Ҡc�_"t����Ժ&[�I#��@Ϛ�rȁ�� �<�S����$�T��Ɩ�O�uD�3��U^��i�fs�{�п�����������Ɇ�|���&'�_`�)9A���P���M��
߇���e�;Z#���%2��g�v��2_#�1�����e}T�\��F�j�ЕX���Fʧf�@Q#���t�	�$�G;���܌
��i
%2�S����S%P���!@���"��$T��������2��>�+2?tՓ:�_E�s��Dr70NH��1O�_���p㮛
QBN{97 ϐ,��e�[��ߓ��$����״-�h0�b���i�}%+3X�,�J@<}���&�ɑvLa�bU����l�Z��4diy��T���@;!�j��d��`�U[�[{(� �L���������5�jL� ��I`vB0��[�h:�E~�wH����m=*Lo�k@F�����(ڂGl	��\b�x�!��">��1[��6N�� A�t�G�9{���}&q�ku�(Ǫ�f���9��s�L���s��n
1�<�^M��_%�gi*0ks��U}���4�T=�}/n���)9L$-�Э��K ,#�Qyj�m񁝨_ z�:�����%̓0��CE�p��t��.Q�BL��-�0&��-N$�˿�Ҷ�=W~:�x��Յ%�h�/��]s�Zyq�^'2��=��-�B~�?�>��,2O��D�{@Ɂ�3n�$@=����f��p�)� �圳����X��_���H�\Õ�f����2.!��^�{��0�!q�'�0{�Q�l/�p�i��h�e;}l6��V�΋`LmXc���y��� 2���!Z��t���ZǴ��ˢ@�N��$��,�]��V�`F��%�n�dv�̚N�>
VQ=}.=P�?�|��M�mX�ގ��	]GM>���vO܏�])�[qb�!��Y�}|}��ޚ����o�}y�^����+�'�zc�H�~G��sy#xc��FԨ���2�N)����c�����I�5:���8����Y5�}x6<��⠌�m4K����2p�w$|��D��8	D��C��N����kF�Q� 9���{��v�T��+�Ea�_|fs�T6q#������.W+0^�΢'-Vi������7*�0tSi1hζ��z�܋�(U�0�颹�m[�Cz��Uy�V�i諿}.p^��\(��>+"������`>�Q��w��1� �JlC���q/"����;�ħ�h�&g'�$�?��J�f)�਽�f���#��i���t;� R9;.ʶ��f��o9�Dܡ�FH�$��R�����_]��߅WN���Kk:��{��,#�� �XΝO_�X�f�*���Бh�|�B�t�-Ʋ���jlu��W��ldܣ̯�V�g}�
��Z ���`�<�e�ib(�RVSX��_��� �͚����������2�@�'�C�#8.��
-U12㽨q�E���� b����&3��(q�#���UT��|l(��0AT8Ϳ�+�q�Qp�8r$�X�/������q���)��[����8-u�Y�<��� %PPJ�o�����ѯ �0�ׇ�M�ln�
E3�ec����j<�	�)��{[�R�I��C�2�����~����!KK�F8�@"+1q�V��=�q͞	��O�j���Ir_-����pj������H����n�c�0������Uot�g���Z�U̕!�$��s�y�Jo�8y�{j�^1�z=�r�C�\i�ʹ�4΋����q}��>_�
�i&5����ʏ��4���.�}z�*�˃
�
�����ȅMMr�6d�]�p0*&Vϟ���)Н	��Q���Þ�\Y�����A���[�ƕ����Vp�E^�����ytG�Q��+��%�C�<���$����D�)(F��:�mݜ?<q#Tt��Z��ƽA��D��83ӊ����Hęo�+-��Ή\�}Q�=W�jT1���J�m��� 'ypB��6����Ǘ�W("1� *y�L aZ�&e��R�s�3 nՠ.���1���|dY��p�O�@����x��U/���� ���^j@\���e��0f-\��DZ=(������/�#��Z8�g5�����/���\��A���H�E��+.�� RT��3�+���UX�2pT$V�I�R��x1���(�M�0Z��g��⼐����o�L����� Z  |�r��>w��Mw�	�F��T����Q�^���>�D�E�%�F�&�&�ү���X3QOI3Ex�˯�-�z��I����L>�����]��>���ऄ&���ӂ;�9��c9I�"\�]O���M����|M��g(�V$6���=�S�>�|������+����)w���V� ������5���a̽�r��3���u��4Y�Ū!Aku�d�sm:�̕a2#SE=�n�`mQu����^چgk{)(y+���ܼ�t�$���}o> �;�NǯU M�n	��k�)Nx�"�	W6��&�����0W���� 
q�%��+�)���3F�wAј��Đ��kә+�K�ٴK�#B�j�0��H�N��0B�K�BOb�.�����#���%U�i�߾@	���5�o����ΰ*�l�P�����8�T
�ӻ��=��B�%L�))���rxp���K��w��P�MG�q=�a�[��}b�/} !��[��Di�Q}�pZ�eS����vPK�R���	!<wc�i$uБWW�s����1zo{����������!N�})3�8���� ��u�'�`gX$߯5>ú�Y�M��휋m�CfC��t�b�'�1�f��-4P�x)�ĕ��� i����Úz������gC�܁\�.\ f��?|#|��
0����|l($���^na�E�Z�r����cl��	�n�����D0��}}����������� bN􀺽=�Ï~�1l�D�:7ty"��4۹p�]d�
̥iE��^��E\��7yG��c�!?8h�B����)��! �`��� B#��J�V�R������Ź��~P��τ� �.��{��<Τh�Ny_<XS�a_��y�]�&DOz32�8{�*^r�l���=��S������r���tXg���z�����t:lD�E�����`'$c;TO1��!1��@FqI�7W�����H���k���=6���G�?��;v�.b�ú�y��;�3!�?����C V�	���'inh����8�ƐP��IB�4��IIXL��M*�m�3�xP!�8�9ll{7��]D*k��_mJ�uS*�<�]�&(�p_��
��|�����]=�#�Ugc�s����/��Sy�\��̰d��ݠ6A�2æ��L������HgSj�d
�$f^����b9?�U*���ia�FR�p��^��ˮ�l��&�R"�)?�&�|��!|eՄ"�B�H�'�*\	T�&��Ŝ���m��'���
�6���L�#�ܺ�p�
6:�\WSV�����ޟ�lw��d>WS�<5� ��qh#yP�zkoY����S�^���΄-;2�)	�c�M�:�@�R�2�B]3 ��Ǿ�(7��������+�e�S��{��扄���<�g�h���x�V��*"&@��[@��(�s���pU�����w�6G��]&�L�wo��5�_��iXqs��c�q�}�Ƞw@�5 TͲ�(<�N�{C1�x"A�FRF9�~�9BU�.����w����V��I|>�S��Ҭ, rD5�U_h94�7C�L�0������E�}!�υcZ\���x	(j�\I��W�e�P2hC���*��Fc,r0�ɇUtQwc��	���$��I{�A.9��q^��X��U#�����-$l��̭I�YўM0小eda\�A��p6��h\�A�8LXo&&���d��gW�TW80�Q̍{�o�G�j� ר�����#�3� ��*u��2�ñIL��q(LO�nbtD�U�0�>�����5��@��t�5�ÁB��;��W��2|_ap1�/3�L�A�[$on�J�FA �ɧ��=�z��3;#�K寘�n��#��Y�'8Ԗ_,J�<DQ�����;�����NI�^��2VWxS>�tj�q�+{�������ϰ�����ج�6�m�!�_��IF]��Ͷ�}�����?��׿�����/~��������}��������W���W��'����䦟�G��D7����o�������~WMm>��}����9��W���W�����c�������o�~1{�����7嫟��5�	����eqb������5l�4����ڢIB�]�"�
$X��8&KԭO��P�M��ݗ��q�����I�Q<7��伉\~�`������yyx����b�I�}M�o�8�i?ۮ�H�2GIqb����%H㏬zZSz%�V��#4��.�}��9r95��w��P���޿���@+%~>�g����HB]k��U>��.g�"� �V1$[�0�1���Q@��9R�&� �m��9u@(ݟ���c8*p�A���E@����tWxS2	d���X�O�b���g�O�sW=[Sﯩ3���%���l"QMg@��^���˦�[n2�ߏ������3}�R\����Ȑ+�B�x_gǆR��}7|�k�~]�,��P��/WO�2*���m�G��X�ݾ���d0Q��~sU=�:��L
\i<_���@����M����.�'}q{��k޺��_�����[��/Z�q����w"���E2��u��&Nߨ�]^k�M��H*��_���E��}B�(bX�͍�7>��lc�1��n <瞡S҅��a���BZ����xz���-���5���(����Kho���a�=vcު佷N�ף�t��xAES���\�q�J���E�����R�/����
��83X.:�:v������f�?D�u�6�njE`(tٟ��������ɍ���l������O�%3~�w���:��u���ptD�����x%�@�ꌥ���<��CR���%Ɖ�D�bu�B}Fz����B��;�h��v)��z ǩvR7Z���7[�d�O4
#�`��	��'��T���Љ����7�I���6|c��JS���>+���?��L�x4~P^�8$\?�A��'�|�^�7���:��C-6���$�'ľg���/���\4�C���������I#r��D3+�:zdaB#W�j����E���x�醊v�}�+��V�C������o<i���o����v      #      x��Ko$I���_a;J@g��h�`d��Wr��tm����pc���\�.�p�6�����@h�^��h�U�Kv�܃�����N\���*�������y|�;_ng��ȗۇ�䩚g|��)�;&ɿ���C��R�?��%߲���E��肋�f|I��o/iI�}N���o�XΤx�w����o��Ċ���oɷ��?~���n�������� ';)rFi��;Q��ǜ�lIf%-Y��i���>�����?S_�����7_� �c�B>y�ȹ�y���!�����ȑ�~ȃ$u�ˏw�]�?=;����a�~�&6l�e��|��R���� N�N���O��1���� Ga�o<_��$��/T.�!k+Sح�~��[[[�%�Ʉe��!�۰?���;��m�����ˏ�R�MW������~l���=�s&�!��'QF���S|Н ��[���ə�;rɾg���������E�O{����ʸ2�#-��J�w�� ?�X�/��E�%��u���zؽ+����j��ד/FNs���U5�;7��?�I� WQ�Ʉ��F9��g-�������N���*�~���4�v��ه���`�|}��ҳ����҂<���֎��~�x�=T�='-�gk�Ӽ"_�n��rin�!�y�#�]?�muɞEN��3Z��VG�$��D�:�YW[J�n�F�5+�W[y2�(�*�^����I
��K��8�!N�#?�����|����؍k�զ3��y����`�h��>��eU�<W�����#����#5��'
��rv�=�L\��&VK��\]��Ŕ�\/#�J�~s�]J�ԇ���\�<S1겉R�s��ӣ'^b!��/UN>=�|����.����c�`�ܑOY���C}����'�m�){V��^��v���_q|�}Ϸ�_�N΄z���E�ႋ�y�IX{uW����/�F����rq�^�	LVV#�Rɫ��)���su/�}�u�(D]����J�e*��*�i��nJ78�}"i�T���n��}|�)D ���7���Ks��B�/#-�@���;�ʽ7(��
3�*���Q���]�ݴ��c]�Q�<����9nH��8�k�9�K���5\q�݊�6IU��>G�$�S�ļi;�닱�=��<}���=ShGBW(/㶷�'6��4/�3yd�a^��[��M�[�����+�NY�-���-����A0Pl��baeb�q4? Spt�l��\0:� �_���(I-�Sx�K�r6��6#�$��!o2�~�[��.gdƲ%�ɥ�8��|ܼNe�4��?( 9�P���?<T�̀�S����=D���ĵ~ W�(iAN�b#�|���޹d�P|u�r�.��(�C:��#���
`c��{��<D��GAC �zԗgx��|>��z������i���L��Mz�OT< �i>:;�n��)��/6�4+��x=��F�7:�i���sqQb�R7{���v�^�����E��j�;x�N�#=�H����d��r�5������ubV��0J��F^T�%
H�y��z�5/��9}+�x�q�зQ�P�9[�l��`)Fv{�
��UAf�V놶�)�a�Obǩ'o�m��j���#{5�5tR0�9���0]P�RHj��p��n��]���V�=�`C��Ͽ�W�6{���d�Ϡ���lh�5�)S�wG�FIr�
������t.Ŗ�r�V��t�� @Z�?K�/�J�3��{������ �ܵ0�Q��r2�~�E���6u�jcDlʨ�Ŧ��_�H�Z����4[�4�n�x}����\%�.^w���ņ�;��|���0d���N,̗T}����_�e�tC�u�j|�$��c�oIWTe\�k���`������39�'���%��0mHmI�{�tK%��L����m�x���ޱ��<]rA�<I�C=u�;	��^�r`��(�9�����<�'��>JӨohY�3Q�,��H1-� �%��C�.��(m���&nk:"�$lφk���sla��3I%����w�;7(�D�/��LD%EU���n�%f�7l���F�q�nْ	`<d�|��v�����W!]5q�Ʒ�����=�Ӣ��ĺ��!���w[p��K���WΤ��>Lӭ����0l/����%'S�R�VZ4_k<x�_k �Z��D.$�IUd���*��#�l_bx�T�E&�(�7��5C�(���E�f{�}�����4-�ً��M�kɞ����ۅ����.�������}�i�lܘf耹�w
���ٮ���{L�\%��[�v&��[<<PRB�l����wt�է���/O��é�\dU�n�%����`�<Ĥf��I�y�P�ٖvT��Ò�<:L֐�דݪXt3D��t�J=��h�o��v IV�|P�!��L��!�r��-���c��������?�$F�&,EȽ[�Fa��n�s������c�M� �����_
��x0`�]AN-�*�Z�|��,,�E����~E�3����pu{�D��؎^Ǖ 6�i���*=[��ƈ:��O0xba����5+2�L&b.ų6�F�����X:QԘZO|�20�A%���&�WK!S��s ��W��t��I���z�5 �X�/i����cL� {�Z��n�z��"�9m�i��د+-2t#��ڳ�9-�0�9�2
��|�o��|�<Ƿ/�-_�Lk�*
���T�@Ws����K���N�6%EP���/��������_M!��-���O��uF(<tEs��}��oe_��OUQ�r�XW�pw��ƒZ�!cʱ����,Mb2���g���1��#�.�l'?����
$L�u�����|�=q��|Ǚ��|�\�y�:cg1 �Ђ���_���LE�u��ʸ�d��}
,TԷ0��/��R�M)�2�����C��O��=���Q ��{�^�MU	�+S�ZИ�h���z2r苰=b���Q�`~b#�<ߑ)�y=�!�b�`i����+�_7�����MZ54�)HXh�Ԥ���ԫ��ш�EƸ��uں�@���X���gb�o�!(v�g0�gឪ�ܫ�,���7�V��l%��j�@��7�v,ܵp#�T��13~��䱧ΚG�;�t2��a�g�(S��Y�g%S�4���Š2j���G��kZ��j.����vj��q˹����G,�W�(@(�^��g]G�Ԃn��r�3v-�F)��I�$^�ل-W�t��G�G�S�<�[�%���������}�T�j=Tr�vo>=��";aT�m��q�IK� y|����<��?��^�z�\��[�b�		H]��K�eT�j6
���L����!���7ʙu�C�-]��Vz�+�vf��������X��ι�U�b���m����F,������B�㚗%�W#�����Dq5�d�t�	rM{���n{�~ߥ�z��#Zxg4�kr�~���*��Z��F��R��,�,�*�<����;��I����iCZ�x��\�(�-6���[��֠�u�ǚ�W�8��D}�{ؕ����E�O�g��'F�ٮ��K�+�}�`��B|Iw�R
c�S�v�)�A[�!75,��-���O�O�@��d5M���K�|�w�2��;����f�8����U�*�����s��s*�K�s�q�̽�Do��0�� d��?H�3��� �h��p���k}_-w�
30��.�yܺ֋*_
u��O��� ��dأ��u[�Y30p���iPb&����/���B��^�')���,k�N����|�;&����3u$r-v�!�k�1zm��	}��V���ޮK����� �]`~�s!�]�xa�F:$�n�e���N��|���
��${R��o��-ݣ�8��eb�	m��2U�m~���כ �����x���d�L�)�[HK�m�M7U$f�5�TS��%���U�8ؓ�ح��ENd�`�?W��gbp�NrTr���K�;�߰Ŏ�����	��-�ιi�ר��2��bpm��9�    r��~���祖�ig�v�D�f��|���'�~�E���A��q�Ǽ	02��2�^�'�W��9��2Gz�7��'l�/w��Q���r-YQ�A�U�kr����.l P�ؖKhso���j˦���^��N��A)(�k��ekF�P��=A~�c'2r$���k�q"��{n6_zؑ�A���|�p�T�v
9��ݞF����d�er�2r�2:7��=3��ܯ{�o��^��Բ�5%WԴ�[ڶ�C_CWih��ѱ�lMsF��/�]t�=CM]�8�����F�A? �������-gք-zz]W�:b�����cN��H^����G�H�q
ͮ�ȼ⫣*OV�|�9�W9�ח���童�#k'm
��ش�Unp�]���bC��K��;�p_�"c�m��D��5�����K�$V?8!�|��3?��G4��������?��Qϩ5�r3I��z8t�S�W��i��F^ʑ�X����0�*: O-�*hYCt���Fm�[�0f��n��z�ʧ�x�cs���V3hy8���E��fzsr���xكVH�Η,S)�˗�|�=���޷���\�F�W�n;�G�ߔ���c��3��5�]�ê`�������(�Ӟ꺓�}���������4{5��W��;Z585��ީ�Y�Y�lK�y�x�7�|-����'Xא����F?e����n�}Ǒ�c�>���6cE��i#!����X���7P@��f#Z�ݑ>HB���.��!+y.���EgS"Dq��
ud_�)�w8����o���[�@�
��g�y�fl�̇����]���)ރo?s3�s��������A�������u��r�99�2�x��E���4l.��'����*^��G6P�N,�璭ȝ܉1�i;kc(�'�� r?IC�#�2�r��ec�.���\�B[�k���S�o!�S-��!G�N{к�UN��S��V��ۿ�@jF�<W��_q�u�O_���C�N����L
{d�6*Y�&7��S���-{��?���.i�2�|R����ۥ��>����m�������O,/���kS��9�~�T�F˵��'U�����{�pn����՚%�46܃��6�Ĉ����n��F���<�0�h[����dq�������@�i�����z�݇��l[��K3e>��&��!s�6�\����UA.D�]��tf�P"w=�=�R�wZ0��w͊ �
=���;.������
S���8�ژT��M�9y�|�.��ѽ�](�����������1�95�Zا��Ku�'��Y9h��GF�+���J�a��9��36��:*�X�67�Ͻ(����>�V�H�"�x
~b�?S�N}�GZ�{������t? ���+��}@2
ݏ �3�9��~�oy>#��^Q%pS��}Y����n�ҬQ/��ڲvG>bV��,̟�0�x]-L��4_�":�|z�C@��V/V*���i�>�~�ڧ�S��N�U�6*I�ܪG�m�Εy�[��JX�{I��H=.�
�c��I,䷦yZ�۴�^���Nm�ݷ�Ck��2���E5J�������a$[��w��r�L�g޾�S�+�"g��T��bLԆ����űC6}͡8ó������	c��~C�r�^�D�h��T9�z���O��M��g-�:rG���Wl9|�cM�^���L
-�R�:�16�!	��������X�/#_6*E߶�>z&�ŊMJ�	����,���K*a?���G�N�����qm��G=���4Z�C���;ƌ1�K���>}��51Zn(<��^Y)q��q�Ry�$s��^�����xb�b�Q���.z�[޳�_1	�NɋR>pҤUo���-�s-�555�	�s���
]�s�!�u�k4��o{�����}�ꖓ�P��0g0�����@��ξ�UQr���|�Vb�I��g�Ҩ1>,��e��Y�ޝ����C�eJ=���N����S�#8�
{da�f;y�yV���7Z{�� ��B'�ھc�P��Z\Q�>v,�z���3�aG���V&�hv��}��|�R�	�7�/;��ϖX(+�`�;JC���I�]���������h/F���^?��������A�dbN��}��!W�=���R͔}�89[����ճ��A�ҸQ�5р�����Fl�D��&3z�1<��_Q޺�ox�q����#1�v-П�Ki��C��l~�.��0�����j��CN�;�wipF1��9xg�](�N�阓�����k�����r�~��2���L�
|d��L�U&ԃ�Y�]�bH�'����1t�W�{Ȁ^�/T�plLjMk򴼼�x`7�`�5G��*J�>�5��u9���B�[��,e��ӑ�S�e�Z���FISc��Ś.Ʌ����Ze�c�1~m$���a�X��H#Xc���:�
{�:��
=}����G���\4�S������7,����*�Y�����x}*J��uz7ǘ۱o��A�Ɣ�*��؊��r��BYh��w��$zrH"!���=�t%�D.����������ې�<Xy{bp�����p�TL_�@��Y�*K�(Ơ���/�eTdB�C2��y���s#��1?�:�G)�#o�R��9�����#7��|lVـG� V�]�Ԃt4V$�7��Rx�?cKFe)@��'Q�����F2ҟ@�<n���Y9���g�Ӧ�X���i�"��"�@�y�c�ގ�^��[��ߗ�(Ǡ��Z�/X.w�uVE���8��A�i�-��ڂ|]����XS�I��t����4���y�6���<��҂�k���<���<p�s���L�7 ��xU&ƨ�`����Q� v:$��s $h��v>�������]!�-�zc��Zl�;��v�Q��Z�?�?�+	�MU�n��|ȍ ��Ȃܸ�5�F��u�?�owl��=�I��]��.�sE)=��?��ZV�&~8�r�Ł���O�����|�-|r΄\1t$qq�'.alz�^D�,L����X�Ô�̄�՛�-yΖ�/Ȍo��N\f���&cW�Ur^o�M����1��q(d�p$Pb�]Ϸ0?��5H�� �*
�Ƈ��c{BQ]���	t�Ib��1��v䊂�q4�v����&E�('�*�ς��~�����~�f��;�ӱ��7�[��Pe7��_J������wS�!�Gʤ_)("�c�w�,�
��B[�~��m�n��kh��,N�B�7���?ر5!�>�W����l�$��z"�Ǿ9Z�*Al!��*bYU�U��O��o�XtF'l6V$Zc��Pb���NՓ��5=Bav���=�Wd�U�f�5�gL+Z�/CN΅�`�7�S��Ɛ4��)���|E����{`4� 3v�����A'_W�����u��'��!�\�7��ֱi��!�)4�&�G,� �1���% c'n*�����뜓�㇪��[��[A ��{�rk��/!��]�m�k��gA�O�}��C�ovw:�n�T�5�Z�[������ʫ�X�Ջ���Tn��ݵ��'1��+[7�gi�^�u#ҁ�h�#pknm����۰��L}?v���/���g��2�7t�Ӄ�Dg!vD�0w����lׂC��B,W���6�G��HÏ	6ܾ���k��9;ho�f�����B��?�5�֞F���ʰ����/��5���%�::�U��gMS�b1�2"�u-�z��e�`���/̜t�*�ܑ���2e��i[���AY�i��t�!�m��}~��޲���us�s����@�<%��N8LZ���L֕���6�>��� �g��L���z��d�5#&�G��XP�I=d-�Я����`(zEN��o���]�J���`gtK>K�շ�eau�M0o�!�i���X�?m�L������z+��HKk����4�"�)�m�)� Aڻn7�G��S�X�'�+Wv.�����C���6��бj�b�$�P/��9˖�/��> r�=w�%^�߼b���֌�/?�4�j�/8�    ����B���ku��:�I6n� �,�R�4':� /����{''��B;��\]i*3�r�jfXI�2
����s-�uE������LT��1Z�_�~�'�3Z����V��Yg9�}  >����~--�Ს�<[�0��%AW6L��6��|>U�<�7{���{	$�I���M(1�2[�-ק�K!�Iǌ��׮�-�����6��~����m�,@�Z�@Q�͋���>���p�����`�yN�0����]bء�R�p�Tg&���T�AZr��n@�[�τT���)?$Ą���I�ؗ{-�� �ʱ-����a�fF|[�ME.��%l��t�$���=M)o�<�k*DGer�ؐu�v+dy8T�{��C��������{"wF�D9�� |z{N=Q�&찙3i�6��e�6c��4��
��H���2���N���!���4�[�ka�a�k��=IΕ�s9"���;��~[�/YQ0�HWEI�?d�ǧ����Z�(
��c��O�9���=��_7�45j��p�������"�u������a�g�L�@}�����\y�d�@�Ҝ�;�3Z���4��ќ�a��"�ȕ'����C��Ů������9�C�=�=��,'���|5�#�lZQ�U�ľ�W,_�,���i���p��I��` �cX,�$���A6f�+�G�X`��ٚV�����F*�EzH TM"d#�~�ڰ5��LĪ*�[����;ʖQ�P��s�>Hq1�X+`Ku� U*
����|EnD�FmD�ۯ8��<M-�G����g�� O/��_ ��;�-x����^3i� -�7T.DA�E�J���x���W��]�TW�;4��w�{-`=笡+��I�MQgd����,@Nm�ꚍ�A���n�g���@J;i�C^<�=��(5{�9$���E�s��u���g�)���.�zh�/6\9u����c�51�g�Ŏ>�Ѓ�;���������~�[�6*6�?���@�1�6�3/�Os�cS����ל� �%'�2�նoYZG����41�y5�K��;y`tU��M:���G�|��3�%�l�T'|��i�_��z�[��\;t>\o�{�0��
���l��dg�	��/_�l���%�e��p��c{�)�����ȇ���{c�!
#3EU#���nI�T^�rnq�m~��z��{~� h���,�麉.E�����^`�"���v�Q�z���o�Q�A{f�H�tmz��zN�؈����-���ɉ�׷�A��z��طIL��'R=aBϖ-_� �G��p��
&�۾�'���|]>��~��\D4L[�}����s^��3�\����X��0�	�~�Ao�䓊c�m��P��Ur���P"v�8��%�ٖ���{��@a�3+�n�-��/�.cz^�eЯE���7�u���}�1Ji��hZP��
cCz���,j\���D�u��C/��Z����fF���m=�ѐ�Ї-^�Z�gl���,c�A����)a�ظ5�cV�H}�G��Y�Y��ڷ�\H�T/�n��;�'�V���k�G��-��f��%,�ҧ'�Z���*P�Wc{�R}� ���'^%g廋���U���y�;Q��z��=�Z��#]�/d�8h�<P�'��4�Խ_ҷ���V�@y���	-��6DK���n
�=5��9ꫝ�|�χg�!n�d(m����F�k��
\�H�0�N���P`�,�g���76��'�Wg*ܱ�{���T.,'7Uax^��9%4_�&_�J<�wy�i/1Eiz�MS�G`8P�:��xex���C����<H՝�ЀR-�Gr���Ս��ٚ��W:]�;y�7�g�mY}K����=��dh��U'
���>�l���a��sÇ�u�=��dʻ�I�v�M����A�=;j�K�-rU�jѓ��-?��i1L�=�WJ�r� �v�;Aj2*���*tɆ�0�f���#��m��S�[�)�_�r���Q������~�`ul�����z�/Շ3:17�V��q|�ړ�{RE�����ߐ�oF�7��a@����X��*q�ft��m�9]����~&�;�ˆ}\�<�{ܰQ�����5�&�܋W>�\G2.�,-�}����&t1���)<�u�(�p_�9o�}?�h������g!��;2{�{e��~w#�H&�R�-�E��:�5M�~�A��k�%�<�}ʍ��D��j�ƭ�ȗ�A�ܷ�p�){"Tr�Z��?���ǳ��]�GZ����t3,n��r߷/��=��>�8�Y�dx�I�f���[�ϟ�����?�9���__-hύl��(�A;!����l{���|���U���T�c���
���wУ��<�Q�X�/�Vy��pG!2K���e=������m5F�~�z2�:詅��X�k��烅�Pu��I��5�����B�l�ej��v*�!LŃԷ�?��rɪbt��Lc�Y��w-�_�R�;�w�R~)�F�y�~dC������͆�Ʒ�5d�K��L���~Gsr*|ɡ�2���M�#��-7e�+��7�(/GܻQhE�Wp���rg*|+9��̲�U�ൄ�<]}:��5��?�|	z8g�=?��@��	!~�����ϕ�Y��p���v�!��a+��{��*�1�Q!:� ���������!3Z
I�b��_u������f�;��f�#�}%���k�5����Nװ3c<��ʊkA���?�O�V�M܎=��I����{-�	�ӣx���Gr�QE���G��<�����>�KF~�W�������IAK[����4v3`k��V@"3��Ha=�AG�n'�o�{�S�y�c(x��n]�5r݆ Uu�Me���A4_kà'%���2�A����*���*j��_S ��B���z��?�(ه�Tu�a�S��i0��w���!��m~�}�� 7�+���\GO�:"��
�8i�2��d�&�����C�v��f��
`ߩ�W��c��v��k{��5u�mwwC�r�^`�iF��Re�n���v`�~�&qS�����T2����狚9����~��u�אE4�+�䬒òoN�"���*�i�Q��t�@f�q���-�7�WN�267�KO*���c4�'��LT�̕����[�?�ը(�����B%���փ�s���ʑ�6�@��X9p(b��A�n/E�1_WJ�"���B�6�ܚ+��떾e����F߮�*�4k��J�ri*,�@�0���m���W�ks��7δ�U(�2�K�،]S���v'i�RL�·�,]��+�h��<�0l�6sР���s�ᘜ��i7~���K������U�v�����+�-x�ن�
	���y��`����~�$��ܻ�g'gW���T@E�����_x�>�m�Ey�C_��y
_�)��_.?��lb"�a��[.��,*�jN�qzQiWW�bF��Ch�؍�3� ��RE�cs�QO���A|޵@�{���HU/uŮ&�`۶>�r���]����QǶ�o]�o"���+�����1�ط[0�F���>i�{1$��9�˯7��h/��[N�G$�깤�ru�}�L����;\N�c�!�o_l#�uSIIw��S�K/���I�jhL-Ŏ��1���hJ�N��ƾ���t�U�l��ld��@�*h��oDFɥ����<��� �L�n���Fh��W4��ï�%v���`
�L��6q�cm�Gid��b������S.�F*��l|T��;`��'��"��a�&�"�U(���,�;H�_7Hđ��a�/�j�ku�z˂]v0Q�k�7j����z��H:^�/F{6��{�4��r1(��z����:��3��/6�^�d�D��W׾�f�������H�r�Et�;�p_�w�k/�����8-�$i˻�H-�Y���D�=�V)@�$S/9������Y������J���7�L��=맩�A����0�sV�V��!r�(Ġcu���]�D-kWf6<�E�Q�9�z�x6�ۈ�LE���j�Ko:������nٺ�-s�7�櫢�}�4��$횻��    ��a`o�gNKQd����6k�3^U捤�v��U"������h��^�u����G}����~7�f�Э��#�]�Ō]I��-�W �H��ȇŷ#�:�=��	��B^ǬwB����(O��w��7�i���a�D���o��nd�J}�֌�@K�î�+�6��b�;��Ҕ�Z�C=q��ر��6�O�/ȝ��
�`q5қ�"���$i�z���<�Պ�����^�!do�h�!��i��{-w4dl��*�9�����O%݁T9�lx��i#?�a�_�d:���+`}����Y,����)�E����GM�DG!A�^�p����C�h6t����O��X�����#M�Vr�~Z����/����<i%�Q�����*��ة���ɺQl���adzJW"�C�B�(�'0"n��a��w��jf���`�ħf��?3Yiؙ
��~�,rlk��\��.2Q��{�����7�D�Qpp/�՛l�)����0O*�`JaK���o����3Y�3X�=�&��oEB�Ea�$��<�XF.DU���u4+�aw�fM��|U���Ȋr.�Z�q�QȀ�~�g��5�Z��K!)k�5��G����z�K&�vG��v>��%��7���̏����S��:ݾ�f�*���t��'��-�Z���C&���W]n;gB�l���	Ҧxj��[eUr�������Q�cV���0���}J��O.|ϱ6a�vkH߯=�CC��+la_���X��z����?-uUyVmG�[���)�]�TT+uϧLnE9�h墿�N����Ť��7=ѫB�������^����hk��o9��5l������|��?nE�B�U�n�\og"��ZGGPc����@Y�l���p�xO^g;5B�z�ʽ�^JQ}�f�]�G���8�}���mi^�B���ȇ�L͔�IèQňtJ,��P쮗�ح�L`�t÷DA Yk{x`������3ӈ���H����u���p�o�_����_�9]h��]�w��<������!_��h�:���I���y��F�S#��/kN����Y8�Qitp����5͗rGfk�^���d�vn�oZ�7��>{C;�ż(�X�z�{�Zq������X��V�(%��ٽX�����\V�ẋQ�FOM<�o=ܥ��0�e�#	�N���W�ЇzP���5Ӛu#�h�����Ɂw�[A�:����E9l�4쫯btx~�ν��T��0�/�e����8�>�T.���>"�A� �O� jO?��W�qY�+:g����c=_����~k^�������Mr�����R�n�w��z����^�c�K�#h�~��J��ۊ�99��ԥu쵗��R�lC�eC��z�c���5Siy`��������D�^�yR{�Y�o���<�H�=$��fr�h-���i�~gU����"�V�B߳��%�
�Z�$'f�8n~�
�}�t_�	P@�pB�x� �-LԵ��MA�|x�W��O���FM�x1�@x����;�G���K]/�/�jj�9.�9:'���Ӽ\��$LZ�ﴉ�\�UE'h�n��L��D���cح���^�{�a^tT]�X�k�s����:�*TȒ-aY߇;�4>%������Qټh`��=z��S�`���a��~)r6Nu8�Q[�υ\U�L93ܖ���+��}�.��3Ap�#.��{-������s?8�/)��˷������@W�|�pOy�f'0L�W71*�����)kİzT��k.�N�U�ʛ�l���Gka���OUIU&R*���S}I��"�A���r�ؐ�%Ճ�Y6<FeH�N�Jj���˄$�,�ԂE��S��˾�8����Z��H�etdK��A��(�l��q���Ge�L��@����}w?Kfg�"ˀ�:RL����Q�NF$ۯV�O{_����}�����oX6��@rr5�(�Z������(l�����F.���늾m�7�&=�QlV'��UG�>���I�2B�r�\zw�_��'tKN�lNw�#�҆?+M/��?��L�&�a�ZA2�IiҲ�%�nwdR���Ӗ�v����۷p_�,ۑ��.�mz���	��[FN�$j�Ldb��|l�Uo� ��C?B�q�q	#T�۶F�����亩}�ϡ|L�������xf��:�z�5�X%���v�ZJ�|YUb��n��6�C3r�e�$��̞ˊRq�b�$�벡K��$�o�ہ�=Qsx��nx��yq���q���Zs>�t��.0���6{��M����Q�=��{ ���{4݃+!������F�Ŗ�`uˀ\�'�:�&ZۢWL�v��0���Yر�~���;�imp���a�0v\�T��l\���mt�R�V̞dlY�A�^z$K��Է��J&3��̞�������Ա��P���ykܦ�G��yx{�"s�����d;Z�g�?Trc�m�uA��s"��f��B��˗/�QjG�E������Z��(�9�V둦����^>V�[Q*�� 7|���tW�ذg'qj_�GVd0N�r�^�%.�S�(Il�+&Ւ�k���#�]l�x�� u�m�S���L�7�/X�:�9q��(�׍lww�i�S�C(�FT�ֈ���U#`�����	����%z�˳z�Ge���x�*�~ܬN���B�	���a�$ Kٷas��F�� �'��|�W<L�i�����_��vPNB9�� ��v�Ƴ'oK~�U�]nD��T��Y��.�4Q����`5��4�����3Zi��H.hw��2�[���R���e��U��<��q��U���*s��a�0ݎ������2���w��"�/$��m�J��&s��~��֔�gO�7v��GOw
���%�F���y66o��l��V��2��F�}�cC���W���u����J�D�T�=�������g }-TnN&#K��#��@��F}	�{��M�ޮ��{��񾃪�ʊ��EӾ���~k ?͠�r��R!MB���B�����h�P���7�ݰ� |�`S�k!�tr��r#�i�v��QZ]�w��nzL�'G�[f��4ty6L�6��=�Iq�n�:���������ch���qo�o��������U�j;�f��K��t;R�8U�8N�g���T3&�y��.��&�8�,�W,W�~��›�����8���ݪ�Δ�?��x�����ָJ�?����.�f���'�9��{�K_P��0ޫ�{��C��_G
2�h~�>�p�_��\`���x���> ��y��>�k&��(�?�ja;Ql[y"�����iu����|���6���Nl;��	a�1�i�G��}�|I��n���0@���e�A�v�^�a�x]���^��𰧋Q���>H>�q�E?��}��8�J� �"�fh��G�ɧt�c0z*�����Z>��~�^#����O����\�o:>�����nK���u�f�-L� ���q��d:�|G�	c|��=O|��TJΠ{��X1��z�}��lo_�^.�,���=4����~4c� 	t�������K�BT �=y����e䖎h �N�Y��6��4�YɞYNN�u�햽�_�@-�P��J��4�ϗk�mc���E� 1T_����x�L$j䷰�//ȭ\cf���屻�8�ȯ�U���UE��Szj�O.���7��k��U&���;�*�n;�	ѧ���� �5�O��G8��8~��c<��C|�}�w#A��FJB��[��r�e��Y:M�~ڕS�O;H"��gT�6U�-1�Dxɽ��3�b-��:z;grK��᯵:A�ny�3A�)�"ԍx_J�5���D�eV���I]r ��\U��ϳ�lM99�ي�����j��}�z���`�n����w��,M� ik��T��hKu���ר��lK&\.�C����p��X�>����\��X�3����v'r��t����5u�@��zX��X�gQɼjꞞR@�GH��]�g|y��e5�׎`�.Nmo����^��]h�c�x��ʨoX��e*j��rH��V�?�
Lda� s  V�����Š�i�j�n��H���w��6�+P����RP��9�Uf���4��Y��՟��烞�9�UQAd_y���I��#�`N�Ǝz��/�-߈��o�o���ka�(��le6����J+�|%N[�����ϰ
M}ڑ�y�	�+���h=_�)�`	{	�w�쮖��#p��3$�'����-+�������K,����y٧B9z�5���Q�.Z���=��o����(�F�S�B^��mr����f|0{�Bx�b_
��>m�/M�q���x����8�|͒f�Xc�����v+�d�i�2nm5=Č�f�0iԠh��3&W��=m�гo����zr��pN�!N�7�G}�ٷ>��No�D/�x��˚r��sw���1rQ	Z`#sNaU���:�q��~b�8���<۬���\;l�ů~������
Y�+!7[��p�8y�� [d�AK�&�����H��O@=q�C���Z�`�a��W��HR�ş��=h=f����&�#J�b_��o�9̒?�ȥ�J�1��m�V�}�0u���)�N'0�s��j�#�2(2۰�w���}5��b����7j����;�����-5�n>vĞ� 7j0PS���Tȱ�S�(���%{VW�S�p��}�(-�{��F�I���I�b�gR�����Z�P��8�-�gk�Go�]Х�SO{��ϰu��^ezڌ�O�ni��ܑ��0��}�74S�_����;;�c_jh��S7�uS�9���o�
Do
~Wt�b�͠Z��=��h�ۖ��Wsu�GZ�a?@Ew�A�ʳ�����U���\���7�D��b���bdq1D��l�-�g��fq&����3t'�%��O��� U�*ɩ䯝��Z��{^���I�Sfe9���}Y��c�/t�&p���F$�*�j��1X}�X�otZr�^E���Ӓ�'=���{��VE���VrSgbQ���&�W�ϵ�I̺m�f���}�oiQpI�yYԑ�<�ב Ai|�>U�*��,���]Ca�?^���FדG�A�˱�5ժ^���a�h�k�,߱��ӹ�F"aV-i���G��oD�MȦ�����|5�*�X!���1��"�+bځ[ЛI@y�;-9Ϳ3�3�&1��C�ޯE��]��L��ǵ\�����@��S�?;J�������Z�t#)ϛ։�W�EXl�����L�W�R�I�{ZS�z1��?��^�O��rG.�˵�W�=�-!��sB��@a��\�p=Y+�y���Q[���#�t����"� ������R��H�2�����|o_D�+�rdq��b��R�[�,�SvR���ˏ{3�(ݛ
��[>��L�aL��{l4���g��k"���ʶ�+������X�/���������G�[�=��k�f��Z���{���9��݉\���B��d>��֡4{`���mi�����>��g���֓����4�Bm��*5���� �0O5�7����}"VK`��_D3*m��z���^��;�.�R�9�T�4��`���ZH P��ՉY+�>��ቆzCl��e�ӻMM>���E�G�y����r>�^w�l(#s'h(��x��-�/�͜ݽ'�*�/�T%��S5���t�����$�B���1'w�ee���V�`\��ډ�z���%3�"4#h`��M��=���uCۓO�
�Ȕ݋���X���9���2�~�V��3r��A�"��_OM�����]���j��e�B��~.�j��ړ
�e7�������8���X�|���jR�:���\9�� �t�*��H�2:~JW�ZS�����7��t���(�8�۷�Z�9�-����_��ˠO�{(8��T;��^�4[��v�j�(��5��V4�/�_l��+�Y��B&����6
��-����塮�����p�C�J�u@�`��~�( �zNN�*s�}_�|�۷5�_O{�Lit�ȗ9���	O�s�����^^/�C��n"������D�*�l��|GK���,���p���f��X�
�ڢ������_.��l��Ȍ���5缫���N�'=�P�ʺ�h�-clHB�^�68ʚy���U��ȶ�U0�q�G�@q�+i���'B��x���	��E���/>\�����.2�䡲�[�,T�����4�ӒL����]���,�g��*l�Wu#��4����5)Į��4�a��읥&��� l��#ĠJf�nx�p�W�A��yN����D�\�Z8i(�]�5�;����-�f�-��"{~ߩ�C�����ΙP�hAn9�W���'�z��|�֒��6�h'��7G�i��U	Z�2rS-�)���|��8@�G9ulkk�{R������	w�k�)��[����*K)둤\�J�sEN�z�'�G��ؒ<H��D,B�{�=��������R��Vyib��R�Ge��.}!�	C��_�z�5Ϸ���b�p4aWv�24�u����]ѺǏ]؉<�dׁ9��u4P�>'Ɖ���I��8WGz������@�?I�K�w�½�gF����"���{��Y��bK}7b���_��6����|U/�*7��g����K�s,��'t��[���%}�k�$���ݩ�-g>[�9}}%��7��#�EN��~�bg6��I��B�󔩏�_i0�ؼ-!��!bk�����8 L����Q����5!�L��Q?v�Nf羷E2ԍ2��� pt�!��w�˚��������{��ج���v�!��6O��q)��X�����5�X[96�ݑk>8c��4Q>e�:�6�(y�B����5G�>z�*���qn
|db��o�=͗"3�Lo�T_kƢ�u�E�
�Q� ��Y��<_��2r����aw���1�=�e�2�v3䎿�;��^
=a�n�&�QLѩ��5���S�ԂEѾ�!�s�"�Ԯ��j�ʬ�i���tS@��'/���K* �~�k�}���;a�������N�6n���Зa;'Z��V\%6'��;:��l��GW�h[\�윏!6���cuV�������;1w�7�<�qOM�.wKX���b�����f�i
t�t�L>F
n>�x�fz�4#{�j��v����������      $      x��}KocIv���+be�@*G�¬H�S���)Wn�o��d0��^*ɕm�c�b�,c4\]����Q���{���_2眈���Y��EE4�U��L�sO����rxts��.o��<�Wr�:|��B&�əxŴ�	��\��~0v�G���D��D�s���Tr��?����]�=���m�{�Wl�7�9;�J
�	v��|.l������v�����J���Tj��p=e=+4�om��2	f<�ך�n�/����~ҳ4���x�<ͤf�y�O���'	���);�Cژ`� @�3����۱��v��X�;�9���E�s��l�N���qԅg��5;Rr��E6I�O3v��ȸ�38��c̍�������k��Rb,��	�֮�	@|�K�j�p�?���4d�C��#��u;�%����=� ;w��� �`9�R��Y�n�>>�in������ �1�6��K-؀'����{�[p�M���܁��.�Q2�,�㴑�-^���I��\x���8,��J|��M��*t���XÆpf��ڛO
��c)T21y*�9�~{�qf9�3j!j�t'�J�1h�AK����S@�;>�#5��5;�u"�86�l�F҅hg)a������)�LcW�@�
vp@��=��D�9�87)�x`iD�3�� ���S�픨���݁a�-.��a��re4g�\׸�ڊtd���� ���h�fPdGi��iw5U|bf��v}��MT���F��@� �Zo��2����ro U�)��D8���#ށ�H�iiYQp�;9߰�&��Yd���'r�1���m �����|�Yo��W�IQ\����el��
�2�6_��f��#�w?l�k�G�/����I��AK<��#A����'	�N:6:���}z&�&�k�9���E��
�	����"4&�vk��5�)z��1������g�,�[���`���~�,�!��Pw��d��h� ��Z�
���3�~E�0 KQ��I�,�����Vrt(�7�"�a���>�G� �A�&��0���*�Ghv��{H���9��d�Х����p�ٕZ��r��tb�e� L��I´�l���B�ʹ�G���:�L�x_��:�.X��$g�({!g��%r<ʹ����#�fn�5�6�|�-O�����)ׄ�q����n��z����0|T|ؑ��,����g���8σ��Y�����(����s��0�$�^�]s?�%`Z:������pIy��,>��.�c����x(Na��K�S��KZr��i'5�K�A��� �:Ԡe���i��h���u�җ�⃸���*ઁ�'��ݍO�A�أHK(�Rh���J��o	-2˭y� cAlA�]�M����i���	�$�
�����sw��{:{v�w���_�,�E��B�%ek��f�'y�K��׹T *x:����
2*�򳭳��e(�`gS�����#�!W��#_`r��_���$��}?��^�������o�D�ki�� ��O�a��ox!����T�zkgߥ-��#���`���c�xd���tz"ء@�`A�1��;6�v����ֿ�>cL�?�߫��i׽b�>��AY^��*��󀃝�,�2?������ZG��ef�)�]����+a~�"=��B�l��Ad;)ئ��Ԅ�(�L�`h[�Nǡ}{yv0tl�[��6^Cv�W�D�M����5��}�|�m���uS��EV8�Jm>"�c�n���G���۔#gzQ}oTM�����l�V� G#�(��S������X����"m����L�� �x�ہnPZN��N���㰸�;�v>g O�O��M�4zs�7h��Qj�*�
=Z�m0���#��D"2��JI ��@�#�`��<�^�m�:��g���=��t�tB��r��i�5�>b�L�O�X�ǡ��Q���ш�Kv#�	Xx�4?EI�Bf���uj�P�Du�C�JfFh��I��^���h$p�M�.8�L)^�zd�K��:��*H�:�n�H�ۉ�bz{�K@��0S33�\����`��s�>�6����7b),{�m%��M�����b��;�u�$�Vͪ���d�|�QppB��p0d���6���e��ΤQf��%e�j	������-R�=pEt6��7���)xd�#Űn-x
L~�5��Kx����h�8
��m��������&J�{2	y�r~f��Hα��[U��̳L��®�0l��Ax���|�T��WS{3��.r�F'"̻-W�>CZ��EZ9�q`lѥ
�	��pdl�Mr���%�6w�q��m��@�H�Kv����qb}`�+�o�,�?�n�U�f�qZ�s��]�-�m�p�y.g�Mu@2�x4�y�|�J���|��z��
>jꕩ$�ܹ1��f�N�����f�8Z�{��^B�,�{���{͎�Ո���m�y͝ E;�*���s�򑶽�����p��z�C7�_������\���B�qh���C$�W��.M��s����X)�)�=�E�%jGCֶ���؏S���.`,w��G�������U����s\mkg���9�6^���O3�5X����W�c��4U�����}��Mjq��L������)�m^plUyy�z����1��1И܈9�WS�7��.E@1���NX����(��B}m$6���U�f��L�X�tlȼ�2�1�Gg�����E��^��ne���hd�@T&�3�#Cg�����!H+���RO㹗T���+�11Y�swۛv^N���&�'8�v�RT�|n�l8�Q܈ܤZ)#���Oo]�wZ�
�T<++}��z�Ip��
�	�H ���e֨Z�x��YGx�~j��S����nx6q��4��h���pg_4��%ӈ�b��{��-䢀KN��"_g'��L<��H�3ښ]�	X��Zi�� g�Yv88��
3�;LCy�7�
����L:�8��W˟��Ib�R ��K$},|�o����ˇR�P��~�,�@�V������N�E�G9�����������ߞW��9^�����G�4B�Z�m�1�{L�].g� 	 �����J��q#�PH[���� *_��o��PE���_��
`���x�b�=�Z�Z%�ӯ�,�r�� �p ���^�K�k�*�tp9|H�ȍ�o .n�}�ܕI3�2C^���:���["�Sd�z-�6�KNy�x��$�dh�8L���;:f7�~��U[��krn���+��^~�Ið�֤X�5�v쐶ʏ?�<A�6����O�<}����
f����Qo9G��_�D��5��5����R �em����@�&�k	��`͒"�/n��8F�pJ�fQ�?�i
f���ű\���l�K�¯�ɱv�RUiC�;�"���ȟ �e�A��+{�Ě�7��b� �����v�[TvJ	3��U�n��z�m��ۡQV� ���[ז��!��fG6��~m��	�)w�WE�?+��9�K3��	���2*��&_: ;�c�u����JG����U�!x��w �����������n�%� =�4��������P���z��#+�9�Nd��_ٝB�I�4+���+���5Ϸ/����+������/�P��$����ݠH����ށg��X�	z��^)@���^�hl��7�&�.�0Gr��Iw�5�nL�e^,{A]J����GsA�(���[����Ժq+����W����8��! UM$}��V˩d���O�tJ�T��a�[0QŒ�2t�tE�B����6vC�e��$�W|TH�Cc3֢{�bL�r��ց����r����}J�o���)9 0��q�^�}�L���%�F�\ ���q���\��(;{����+���Z�z��Wب�Ӊ]��qp��>��DF�����4^�HR�\P�z]R�tT�=�+L��ʆ@��'���������6�t�0�Sa���$9*��KW�nӓ    p�=;C���SkX�v�oQH�rfƢVs�W��/hQ`�0����w(�r{��a����a*�.H1d�+���!\iѷ�X`��i�W���b�= �Y�D.EaVR�=�l��\X��i�1�(5��rv��&q�F*!����a��a��W1���x���\�ߗj,b��˶�S��Sԫ��d�K-¦2��b�%����B-8j�Y�����_�iU��$t���~K������_KW�{1��؝=�������/Y���kg%5��I�@do�@��7�~�D�5	O�h��O|��\̸��f����Z�DT��[�a@�-�Ot�P]f�q�W��qu2`WE�(�V9xk�L2IM$��|���C#�^���<�v	,�n2I��خ��[��WF�in,ю+�[Z�N�����e�J<}�,�4�l���w���R�P����&C�Q/b:�&���.� #�Gʾ��0�m���
��e���=�J�[��$*�YY���E[�{#�8�{/�z�ct��r�[�A����_��l�րmT���6^}�H-Ȼ�}L8k[��h�n��o}����*}�|[й��	��]%�^�,���8��6���/��j�f 	@ӳq
�K	PJ||��(H)��E*ֲ�AR����%;0�c�N*���N�W����������$��C�^�l����￪U�~���jy��$j�,�b6�zC���ʙ /o<����6�=��}�}' �4 9�%�e��)��O$n���y�����J�;�s/������ ��М&��ȑ����}' E�{�
��X�P��r��J�W/d~���p_HJ�@��/ޢ���]���:7V� Z�v�����[s��x�k�U��f��]Z��	��������2,�E֬���(�7N}�XK1��"����S�g���PP[��ǅF�c����ww6���q�@��� �+p�DZ��'Fh�q��c)�\�il�c'��c��n�[lZ��h&-qt5lid��xi�8�CX0C�*���5�QK���q�������?'���ݘ%W5Z�%�H�'��(ޭ�_H�hJf���w���#���\��=+�����b�x�Y6���8n�fG|�|���l��+1و &_F-gdi�����Y�œk� ��qK�����)��	�����\gCV>�0Y幵ؿ42ka��k՞����=ԴW���3j!<ꝍ'�\�v�Q��f�vv���/R!msp3d����y�iov�!���|�zX!�+A7�r;�fe�K�pY�t�_�x�#^d8閦�df�Uv�����C�F����ʧ����gD^�=jkq��b!l0[�9WbQ�C>��0��ė<�J��@����M}suqҟk�Im[h��nә������J��ܸ�Ӏh��{�6�K��k�L}#5�F]�U~/�X����Є��4{��;��s�4֨q�)"��(�E���!�����ґy$������q��=�M�t&�κ2��H�U��7�_Aȵz'�@�7���F}��^�n��hh4�b��p��w��ݚ�I`��S���*[��=RF����#G����M� s.qE���I���[�G�:7����V#=���Eq ���c�)_�^��hʮF؂��>mm�����g϶��+����79�Y��4�yTqy�� ����/�J��ՊG�jP��I.����@%�<�_l����\҆nΉ ��TQ�������yV���Yt�2׭��){�u�u;�mט� Э�O��|np��˭E�����%������ܗ��$���{k�B���I.Xu����h4>�Wb���R@�U�1�%^���~�i��wwi��Up��{/�b7fƫ�¦�3^t2��5Q�jrsR~��[�mP������/�r��� V�&�z'G���Is��*��K�s`�Hq�/Ր��|��V�W`-���. �
�~��1E�Lmqi3���֐�U�@�t�+���O�^z�A?\o�M
O�!�Xi9�f��<�����ҙ|��o��F��I�|��N�]�10��������&+����N�e�.��}�僜�<wmvN л���J��.z���,�
��b��h�E�ځo��.�!�T��ͻ;~��{���{$'έ V�I�>�7�֥D`	��뺕�S�N���&>Q	�{����VV�	26��W��a��M���`F�f ���3�_@���r{�N�|t��2LŃ�Jt6�f�<WYn�҂=�-��������AZ4D�\�1�ň��S�j�ǂ�C��Av�m�⏵��&Šңۃ	`j�?��O�poͣKk9Z9����h�7���Ƥ����̪tP=/1�ʛh0�h���≠5c\�v��O�"��rnFR<��g�`Gq�����?�Svg�$խj�2���,a�j�r���H� ё����r����l�8P���C����|��#��BMq�n�(ɽ4�өh�ТN;$x�.����s�U��ʱ@EwkŃbC��'��b�~o5h�W/
��X��Q�v�Oc*c(F��Z��ư�f���m7`K��9NP̕�/ܯ?9�r��K=�S+'~�>���t9�s�KJɉ���X.�&m%>S
�k9���i��wg�Q�C�����E�f��DUM���;@~�<i�����T�Vq�2lJ� L@��d�����AD4n��Z�s���+N���v(%���|�e�Œ���i����<1XP��!n���:���ӯ����H=����'5hK �	��(��~�!ʭ�����~��{�VN���_$ �%�Q!����RhÞ~��r�����/jR�峸����-����$�� .��l��W�� d�ˏ�������d3��4��("��&%e�B=H�e�~
���.*L;I����:�r�Y�o5��Z��FX# ���NBW�̝�S�M9�K���|�ɬ/���e��r79=4�&�pW0���u��=�!�j!��sf49�s�\�_�U��}\�*��J�4�R�8OS�if�����WЊ���W@��S!f�����>E�KA��\Z��z��z��_>I|�Jh���d~wu�.����.?�v�98|K8-��j�<�E����$�}��cwƺ��ڐ�f3@Y�rB}�V�����|1D�R���R�@�]��
p���
�+�g|�'���X���N���e�,�nWqwa�t�ax�4�o��L�b�P4<@�q��\��ɣ�����Q���5I.ā�
,�*�9��w����SWP�?� ]�s�>�6c����mxH=ӟ��>��)����o���F����s�ؾ�iz�aw��nʳ3�n�cIej�N��6�L�����w�bJ�ɣ���v�}s�Qx)�&�L��G�}��B��K�$�C�Dyp�]p��$���W
�������z
;�g��G�I9��0�8;��ʑ�4��s;� ��ٳ�%�I��&r����V9	 ��l�,>Ȕ��-F &rֹ��� 4ʘk�0>�ni�R<ewe8ٕ���cAj-ɑ �A�g:�6
v��}U7�����B> �㜋��]� �$����3R��A(.k�%��c'ߒa:���n���`9+�-��t������!�#5�55 /��cuWo��,>Ѝ"7��������܎�cb�v���{��+,��]��fl fX>�ܚA��N����N/f��*����~���~��y�"��	���h6X�h�V�~��fGJ����&�K��u�Nk�%�Q�O������Z���P-%���[m(����Jq�;!��P�~�}�������h��������3����3�]=UAW o��)�Z�%�*�=<�9��"AWj�턝���7�y#G�[���Y��@�E������J_(�z�J��[w�,����o�n��I3��rQˏ�����G��Dz�z�6���"MW(�~-�,���|��I� }|�s`/v(V��?Ezh���}{��y G	  ��"�*���<Zy�p#���h`��*�48�{vg�q<���ÕQ@Kɮ�P�WJa��t�ᯊL~��y�,��peA!%b���
����C�?6�"���0|Ao2�y)%�f������2���?*������e�.����Qp�*��&ܷ�����bLJ�3UK�.������AM���6�©��@N���\���,:�z�+�=����0��X�>�ԅ���<����� �ۥ����Ap��,&s;)3�O������ ͘8����x�qM���xt�iR�!�;���>!J!�IQ�.@���2TAsbk��'�4�&�A��"B�#�S���!��rk���u�n�棍A�J�=���E�pS҆��#�Ձ�w�a�(�B|[_��;�g6�Ȕ�X�Z�^�1G*n��ǲ�0�]��3�N�*���M*R]�@�G�O6�z�ڈ�e*�EG��F:�V��},�����?��	D�"-se�@��7�&��*[Ό�&RP�N|'�0n�X:ץ��t�����~�s+�s����j���̸[6r;�u"l��p�c';����[72�F0��ǴD�s~o�ȗ���L��P �9��^.�$�w�  �Q��֒��\פ�-WS�!��M`7 ��%�1��li?���F�W|�a�L�!٦
w>�{�M����cަߍx��8
�hi�p�׍����Ƈ�Z�k��7|�.`��J�����j�} �v͖|��𕛞Dv�;�������8�_߭��0U��N�@_z��K�ҡc�j6|7���I�K.�<��\��ĩcuĝ�n���wͽ'��]!?��>,m_�����9|��-A�wT�V �]i�D�'Y��_~�qP|�qc^ҿJz.�b��kz����O�#�	��>� A��U�?ڭ�>�}>� �,g��q ��ٓ`%-�n�ME����_ԭ��t_���\�bw�] ��b�����72q����5N��{�s�g��_�¼W�|t�(�ʬz��OI�.�cD`)Z��[>���#p��"-WH�!\�c��]3/� ���`�4H�\rM�y`��6`�(�pO_1�=�X�9�Ce�?�	7�zI?T�$7 �#"y�e'4���Lgغ��V�y`��j<�rc�$�:'�_�O��5*jw=򏒽Ge�o�uu7��
'�=�*Z/:z�Bz�dI1�x��lI^������;�ф��v7��v�Թ|{qc�01@ā�׵���I,|A�i�Jj4SKUS��h\%��hPS��D8��&�h�U��+��G%4h e	��S �VْvZ��n�'|����h�#�\	"UT^��a�c�V��9�;_'V�a�����w�n!�g�7�J�f:�,�;����P�M�gFZL��)�Tmv����A�ާ���^��&5_���I~4��v��=�g5�������%Z~�f�?8u�u�f�>�ccAܨ!&0�a������Y�8�x1�&�ek5\S=������x�����z��|���Df8��0�7鎢�c�L�FGb����sܒ;� ^�ΧF�~�T&h�3|7��:�J��6+��<,Ra3v��agd���/���{�c��t��MЯ²p��Vx�-'�+��Dv�����l��ciӬ
�o��}��~�W�b�ɟ�M���[�U�m��_KM�����5�x�ޘ�v��$w�3+�������nHe/��m�o��J��8gY��8^�-�蘷�F�c�.5�(�i=ڥ2.$��V�抽y�bYX(�� �XX+6�Z���g�ΌΊ{��{7�#>�n���&�n3��F�ߑ�.��%�g�)���2B��1SU�O8����cf�@�����zC�T�7����j�@گQ�����#����mR�_�<*JZ!
�f�L�c�6�/�[�(QQ�.�s]��o�cA�k�Z��(�Y�d2��v�+%2�hn/�(��vcC�rUe�h�p����C��J����kT��<W�09U>�2:ޥhA?��q���6_�aj���� �S/���iSQ����F�k�H��L�6N�L@�����l�p6�6���@�nn ?��^���h3Y\ʸ�nm@��$+����,��x�C��sܖ���]���i�B��u&�l~_i����p-炽��ic��reZT���N�%�GE��܈4��m��<,���Fl�%u�2���
�cW�1����v�c7O�^k�����+�H ��D�GQߩ����VF
F'��х���pAn`Q/]��÷Όb�q�QJΖSU��!�}�qzW���Ξ���hscƵܖ�+_<��h�O�C03��l暣0���14��OQE?���u� 6      %      x�͝͏#�u���+x����@R��$���-�4�޹O*v�#�Բ��#A�9�l6�da���� _z��
Y,��Hr)r;�h������#�H^\MNn���jz��ٌ�����C�a�K�6%+���AI� �W��Y��꧿Bz��'��z��tjߠf�i���R
,t�����U���W���
Ķ��>OR�� Ӕ�+�[7r�K�e�
�U�������s.X���5K4�C�Q?��r��S��ҵ"4�P�E���R�1P
	�2�ܯ;�d̤Lt�ű+7,���$Ec���2|�i��� ��� �zK�J��<���/(<(_�� 4�y���2<�	�S��%����a� ���^�$Ag��v2�T�&�FV�cH��ܦ%��C��Xfn)�e	f'\�S��aq��re�;��+|����e,Ac,;T��ҿ�b�.���ø���� H�E�E�",�o�Ը��3c2�Z�F�xA(D����n9HfK6ǌ|F��r�XR�H�h*�Pԧ�s���R��V��]Wضd&9Z�&���6�t�W_|����c��}
�v��E�o��d!���[�U�����ù�f�q&�*��,��'�s1U)��5 �,$��ͪ_+����[9틱����5I����q7�f�i 8�8ƲD���d�]XK��^r�y�=�:m���(N�Ulϝ* ,��!G�Ͷ��=R9�E��8jԓ�D	:d�(0B��,��� M�O�� t[5�p����Eu��������]�Uo3D9��E�3X�p�{�A��p�#9B��;+��e��0E�Ł	�+�XȂLΦ9���ݚ�g=}��S����uk�3�����p�1� r�ܢ�]�$aP&@�|]G�c����[k[jGb �����D�P�}F��$��^;r�nص���t������G,�/')�/U=kO�w�.��3$R\�Y��L���I:_�?�8\�>8MwKX�-򤵗S��U�Zɜ�DN�α�頖O��5���\���3
3(��Ih(�w������g0��(�NA���=H��)�b�sK�9����߶��I-��	��������Uąp���p�]�)�	�AջA�� �8�mUW�1�Q�yqYR���;�v���&F����ͮIP'I����ԭ�<Mp:�!!8��:E�p�b⌬�ݒ��J�w|�Y���"R�[�0�j�Dp4��]2�MUq���>N�܌�N��8dA$H�ƌ�r>��L�]�����jk�Mo�F�A���v*$�����Y�yFa�B>:�"�1�.@�Fp "�#̎�r,I\�o�����.��`�J��X�9uc�v��b�tÁ1��	�ǷK�c�3GR�R���S�����2���d$�Hm�c��ۻ�xY<n0%'G�[b�]�(��%91T{6,AP�N�/�6)(Ȋ��Q�7M���} ��L�T�9"0a7R��kNI���m80Ap��f!�|�L{f����G��CY��ԭ뙤?��h�U ���k��I* ���׉�@G]PWýPݼ��m��+���K�b�V���X�i�,�'��o�OX�QHb~���zRN��b2���7$�c�V�f�5�,R(j���o�z�P�)ѐ���Y�%�Q���gjY��N29�����
F'S쉧^��v��;݀/w�<&N��`����pMxM29"o�d΅t$_�i�<�js2�g�X�G/����������
�n��.R�2��V^��PM��44�gBI�Bcu.h���E�rA�s���*����j�e���;��w�)&��~�E�8$� Nq�z�Q㨶5�fb�>�<f���r��+�A�ɉ�U�4�qoud��%�"��5��1���d���<���8���_��?�i7>t^���_���~��Ǳ:���N�Wx�H�!�[�iA�*Q��kk��� �
�4�V��h�H�D�.V·,3���]�� �;�9��St�3�S�Oiȵ�tM򛼝�E����5�:�Ŝ;���2Oe�%+2�"�� .QZJ�_E=��O#L�<�p����(W�aU�Ű�,��f�v72J��lRa	1 "X��@�řO'�Z�D���Ya]��H�#L�z�4��4z��S"���#��I_�O��SG �d,�����W���z��pO I������Gkh1�5͸n �yU;Soz�~���$�<�b%e����*Ӳ��U�F?�%<f�n8Bi�(K�p#XO���3t��4��Y h�9��	Z���%��=&�#C�,�<Q[��6W���:'�,0Y���b.q��'�'E�%�Z��2˜)",)N��]&RuC��7��Z�����e�i�Io7:&
ΥJͣ)�w���F�?̢{'�o>}D�K���D�����B+���� �o�H����O�^S����}�Y�ܙ 0i�=]9�����c�}��`��q0Tu����|��,:���S��v������ċ�{jh��g�w�"�	����4�����d��p$�Y+�e��H]Χ���ء5:�(�ϐ:J}Tn��PH��x'�'�c���1 S���ĕ���/K��Q���Swh�9$����S�U�b��_�� ]Y1r,OW#Ζ��ԅ>L����)\�7�r���[cdnF�(����/��s 𙠏j��f���� �vj��i<H�1kB�LUJT����s����Q)k��l��H����]&(��24���������
!x������ �����ś���~�$0^�*�j�y��/�)+� ���-.�@�&hHVLQ�Y�A~Oq�"G�D�"K �\/��iX,�{ۄ��^2\rʓ��P���!Hz,�� �����23A���r
IBԝ�>\�m(z����[ V����0��H>�AcP'#<�&78]leG�S(��<��\������X��o�y�"��^��w,��ȿV)[-l=e;!R�X��Xg��8�3���E�<E;���GOL�b��fz�E��)�ʻ%�OѦ�ކl|����.�A���0ق_��S*���$��³�%��s��K�����f��s w��|�uC��:儕E��ྒ�t;�����m�����l1�\*�i&���N�$[+*����2L"N3tr'#�Q�w�s�>,�?~�D 9I�OU�-0�!�����w
��e�*ҽ|?P�F��R?	$k.|SI�u���ۇ��ҧ�+<�_[�d;��������,����k%�I�$E��Fs/L���3,fyb�o�v��<�([��,�Qw(��5����&r�:��\����2U��>�꿽|�M;&m^�x��˟�*x�83��2�o�{���h�V�９΀]��еj�Q�7EW�H�����'��0f<��;x��g*2��T�lǙ���&Φ?����%_�C*.0͑��u.�18��������L�-�D_"y����&K՛�a�G�IqT�t�<aʧnW[���@�*�"�D�S#�մ�?K�M�#jY��|㇨i�0������=)�u�� �%�ұA��n���ob.x�H���M�_��a���;ň^༿�L��� �?b)S�4a)c��o�vf��K����|�S�)�uK�1�Z�*�ݳ�j,-6�\�Ј's~��}�3���)٠�l̏��d�?�Mf�������8_$�d�z�^�A�qy��Y�}�;Ɠ�)F�Q�c�#�!) }��'p�����`i���"�$m��t4v-�c˿���UA[�iX"\rU�Yq�,���X�c i��0��(p�Q�e��0*\c4l9�d��K���"�j�3������㟖E��T5 ��mxY�	�z-����w��[��!��f�ga�Xn��O����8R��^��bN�� �/|��;;�����=��`���_7@�ǿF_�蒤q@"$
�����!�Q� 8 �oP+z�\��m�j]�M�� ���Ïb��C���3�7�������	�� E  ���]TuX*̏�P��+��V�F��L͒I��<�E�0���^}t|�x$�4�)�9G�i¼DӼ{�!�Ͱx��m	���?���<Q!&�.}"�]NO���z��h��������h,���	)��H,��hz�V`�����(��:o��y��O��R A�>y���(�|��~�a��pfЕD>��҇aCuu�k)������
�����v-}i��;X�9�\]WS���H�Ṝ{f�zջr��R�V1A����U����b/�z[P�x,*�k�j(���埽9����
�rn�c1��?u�?�]��F)|D�{%\��p�>W��N)X�I�-����C�Y�.n�S�o�3Q�d���zb�rQ}�j�ro!Y�0V�~���L&�Xq�`�������'��z	;���>��y�C��me�b���A߼�g��n^tj��1�A�K��QB,q8UF�=^r��=��w�kO�:UR�8]��8��jƅ_�eti,���fy��=�	8,a^9��R7�i���i�$� �H��d^��wb\��[܎�</��8MyV~�g�D�腗����"��yY��c��^^S$�l�"��'�\�O\0/<q�D�4� ��4tf��Шq��#��(��E�ֵGy��.����걈���n/�l�;ӄnN-1��Tg �Y�����8�æ�ˇMݹgǄˠ�΄z:\V�8��ɬ�xޏ��/�T2q-��R�<�t�#V�x���ai�0vۖ;��L�zs��T�4���������wg����+�����k�^�+\��浧Ɯ��;�5Lq'��
�w��c^Π����Z���״�� -�]m��nX�9n�p��#�{}p�U�;�T�������t�$�7Z0��7�ޅti�t�D���;�4���w��ղ��e1�Y�=yPQq�0/���h]+���s�!��SA��'y�x��"ջAw?E�c�Ͻ'w��+�[&�_�
Ƚ��V��'=;p��_j�c��R�� 3���H��hv��n7J��#��	,��F� ��z몇b�V{J���U���zv��C�M���w|��;�Ǟ��cxT�X�^OXDOɱ�4n=��h�ՓA;?NT�2k�'7�{�	L���u=�
M�M�*�z����U�`�Yn���2�d}�(c�	��=���~��%AS.�����T;�7TO �鱘����&����h�n��d몀�V�HĘ��yg*��r�����7TQ�w�Y�,��w�N	�懑�5���A�mְ�vr�@7X�j�`�I�|E��j��f�T�c�@&G�e�މL2P���WQ���Bm��g��E
Կ�j�g���z�ӷ݌k���Wa����w\D_S����r �L�q�g)f8�7T�D���~�@�E��uC��v�o��q��P�^�'}SFOc�5�i||�a�rtC�ޝ��PT�^>�@4Qy �������Qh\) ]r��Sf�0Yyzfͽ'�M3F��a�ZHB���;)�,Y\�9I!����&�W�ޭ�ȟ�
�ű
2SU��OfrV<�꣱�]*�h��<Q�6��+ݑ�:�S��9I	{�A��;�����g�9UB��=��+9���0�q�ɴ����F�*�B�h3�}yb	�,�>�Z�Z�zU@�m��f-��</��Q̓�|照]�M/�%�d�=���@TN�^rE�<ח 8�JӰ<��t�c�!���܂Hvp^`�ft9A�_�0�^?���|�*���9�O �@�W^�c@&R;�v<����O�=ΡL�y�G����
��^pLlM�?}R9Y)J�ɋ���]'�x���L��4�/��m.�����>�aX�����wM�^RƲ����_�Pڃ������}Le�fhܯ�Ӣ'9���'�r�ͮ%�;�%�0srt.gܐ�n(B��S\�9\ΆFx��T�. %����Q�p��b����չ��x�|�KX���E����R��®�ȒS7;V������<T�"q������5�����N3#Z�|1bFd�a���Ō�{W�^�Ig����#̒���,"�)zv�	'? P�,���<_(f�0a����f�(x��DzDj�:���TO�b�s��k'�_+�VX���4M�f�
�ʿ��Z^-Ȯ��L�)�o�4�7v�HK`�>��ˉ�h|k(lϘ��$���ϗ>SR��lLdҧ�ݝ��d�q�3k糤�$�3��e�+�U�,N1xTN3�}B��,ߑv����mo_�2e��J�8K=�t-��t�1|4�|��:�7L^�/`�z��ۖ�8I�own�kP���pJq�f�2�gd�EBR���ca�S��:�=�S�a�u_@D�G��P�0�ާ^�r�/��5/���g�%�z�ۗw-��;�ܣ��yO?���ϱ�m_߾����Q� (s�3�ۍ�|�:��Rf�;�i�SQ��N39z	��|˪���B������;.��<i�S�xV������4�4��д� f�H&���j6�Q�m䷜m����N��D��i�U5"��{>�T�RU�!�W�y�8��Ѷ��s0�zu�F��IS`��>�f��O�װ��ݾygy����w{���w�c�L+�h�3H���'���K�>��R�����zh�0�L�t�u1�;�J��$��Kp가(�\Dę)���3��A m�I���9��G\�CV�`㒭^��:#�ġ�F)y�|��w#�Y���'�1�fBձ��OJ��b��j:C����ʛ��*�K��[(��[�5�oW���{����}S�?���)��:�*����ux�2��ҕ��%�k��yt/��s=��%�o����~��ݣ�\     