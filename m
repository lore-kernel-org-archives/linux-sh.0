From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Date: Fri, 03 Sep 2010 19:34:02 +0000
Subject: Re: [BUG?] rename patch accepted with --dry-run, rejected without (Re: [PATCH V3] arm & sh: factoris
Message-Id: <vpqr5habp05.fsf@bauges.imag.fr>
List-Id: <linux-sh.vger.kernel.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
	<20100903182323.GA17152@pengutronix.de>
	<20100903184351.GC2341@burratino>
	<20100903192907.GA2978@n2100.arm.linux.org.uk>
In-Reply-To: <20100903192907.GA2978@n2100.arm.linux.org.uk> (Russell King's message of "Fri\, 3 Sep 2010 20\:29\:07 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org, bug-patch@gnu.org, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, git@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> git patches include additional metadata for renaming files, which gnu patch
> will not understand.
>
> If you want GNU patch compatible diffs, don't use -C or -M when generating
> patches out of git.

Fyi: actually, GNU patch will support git-style patches in the next
version according to

http://savannah.gnu.org/forum/forum.php?forum_idc20

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
