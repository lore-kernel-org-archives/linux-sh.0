From: Alexander Lukichev <alexander.lukichev@gmail.com>
Date: Tue, 10 Jan 2012 10:53:41 +0000
Subject: mach/debug-macro.S for sh-mobile
Message-Id: <CAAHaz6Fn6oFMppysdfFtmbhEc8raSVD3375FusCj06A-sV=k8A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi, all!

  I'm new to kernel development but would like to port it to a new SoC
which is strikingly like other SHmobile chips (e.g., sh7372). I am
sorry in advance if I ask too dummy and/or inappropriate questions. If
you feel like I did just that, please refer me to some mailing list
where they could be answered, or explicitly to /dev/null.

  I'm trying to compile v3.1 from Linus for a Mackerel board (sh7372)
but with DEBUG_LL and EARLY_PRINTK enabled, and DEBUG_ICEDCC disabled.
And I get missing mach/debug-macro.S error. I have not been able to
loate that file anywhere for SHmobile. Is it not intended to exist for
SHmobile? Id est, if DEBUG_LL is on than UART is not used on any of
those chips inn SHmobile? Where could I get me debugging macros
besides writing them myself?

  Thanks!

--
Best regards,
=C2=A0 Alexander Lukichev
