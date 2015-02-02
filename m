From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 02 Feb 2015 10:06:20 +0000
Subject: Re: [RFC 5/5] watchdog: sh_mobile: add driver
Message-Id: <20150202100620.GE1058@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9crTWz/Z+Zyzu20v"
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> But I don't know what's the maximum time interval you can have in the system
> between enabling the MSTP clock during system resume, and the first call
> of watchdog_ops.sh_wdt_ping.

Most watchdog drivers seem to restart (or at least ping) the timer when resuming.


--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUz0wcAAoJEBQN5MwUoCm2TV4P/Ro95UXp+RSxlgAL8sQx60j2
KpDE2NCckLV3TxdhHpQZYLI50s9xJJnjqRxa6TrGo58CS/R0Y8sL3NZVAso3PM+z
KhPVpR71j0yfGMfyybhMl1srw4cMTbHCTJcoYwvoYWSGqKfGqXDKzNLRvUuwaMKZ
sQagbrqLpxpTcR4v4CD9siIwXnutyZrAtBu6eLcBuqHqk2XS6/T1dQ2gec7wk9xR
VlTbEVLxtcdkR/AKct6bFdidlvtl3Mr2EHaAIODTPtakO3ovvhvbPdKhXBpIufyq
DwBZYgCm++VAucNKwhNnLrqdSN1BTRLX3sshx/4XzT2rpPy/CE/Wsy3z6G12HiLN
1DcAYBJ3yPcmtbn9+Xt83u/aYXpQ9sq8w8vGKjNqLERWiQj/ymhXA5yV8quDlO7Z
4rehrDceEbuVHHFIXRqMT3NiLli32ZwcxpZknD0r0FXc2Qul/8vjf6IrmMby8Srq
bcLUhC81tsucC7Lyk2/xVzR+Gf8qr93k3etHySXjx0rQGSrfo8Bxg1gleL+9G6hk
ySpfCTAr8R0k4dr3CworYtoXufc0t9Y7bG5dHejh5lv7dPjUElZfFhxUKEzjI6L3
+j23DTdADWiAPMG/gbEFdpg/BgKo9Yisz5V45reeCOiIc1wltHcmOZZ6He/vjrlv
5c61DFf668iGXo3KZaao
=FHSK
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--
