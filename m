From: Markus Pietrek <Markus.Pietrek@emtrion.de>
Date: Thu, 03 Dec 2009 12:36:38 +0000
Subject: Probably cache synchronization issue on SH7723
Message-Id: <4B17B0D6.6020105@emtrion.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hello,

when starting bigger graphical applications they suddenly stop with a=20
segmentation fault or a bus error. If I execute the application a second=20
time, everything is fine. Applications that are linked to shared=20
libraries are more likely to fail than statically linked applications.

Changing the cache from write-back to write-through fixes it. Maybe the=20
instruction cache and the data cache are not synchronized correctly?

I didn't have this problem with the linux-2.6.29 vanilla kernel.=20
2.6.32rc2 from=20
git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6 introduced=20
it. And after a pull yesterday even /bin/init is failing.

On 9th Oct 2009, there was a similar bug report for the sh7785lcr. Does=20
this platform now work?

Mit freundlichen Gr=FC=DFen / Best Regards

Markus Pietrek
Software engineer

--=20
emtrion GmbH
Greschbachstr. 12
76229 Karlsruhe
GERMANY

Phone  +49 721 62725-45
Fax    +49 721 62725-19
E-mail Markus.Pietrek@emtrion.de
http://www.emtrion.de

_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch=E4ftsf=FChrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or=20
otherwise confidential information.
- If you have received this e-mail in error, you are hereby notified that
   any review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.
Thank you for your cooperation.
