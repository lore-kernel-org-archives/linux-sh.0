From: Rob Landley <rob@landley.net>
Date: Mon, 30 Apr 2018 20:27:43 +0000
Subject: Please fix "make distclean".
Message-Id: <65be189f-3dab-6032-d096-4deb49f78e8f@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Clone two linux source directories, do a build in one followed by "make
distclean", and then diff -ruN them. I have
arch/sh/boot/compressed/{ashifrt.S,ashldi3.c,ashlsi3.S,ashrsi3.S,lshrsi3.S} left
over after the distclean.

I assume these are generated files that .gitignore says should be silently
hidden for some reason? Given that "git diff -N" still isn't implemented, seeing
what a ported patch looks like when you're done is a flaming pain to do within
git, so...

Rob
