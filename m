From: Andreas Gruenbacher <agruen@suse.de>
Date: Sat, 04 Sep 2010 21:46:11 +0000
Subject: Re: [bug-patch] Re: [BUG?] rename patch accepted with --dry-run, rejected without (Re: [PATCH V3] ar
Message-Id: <201009042346.11787.agruen@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <201009042333.51419.agruen@suse.de> <20100904214527.GA20444@n2100.arm.linux.org.uk>
In-Reply-To: <20100904214527.GA20444@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: bug-patch@gnu.org, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

On Saturday 04 September 2010 23:45:27 Russell King - ARM Linux wrote:
> It also makes them incompatible with GNU patch, whether or not GNU patch
> understands the GIT headers.

Aha?  Then why do you think GNU patch tries to understand the GIt patch 
headers?  So that it can be incompatible with GIT?

Andreas
