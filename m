From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Jan 2008 21:46:37 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.25-rc1
Message-Id: <alpine.LFD.1.00.0801290841030.3505@www.l.google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080128095919.GA8546@linux-sh.org>
In-Reply-To: <20080128095919.GA8546@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org



On Mon, 28 Jan 2008, Paul Mundt wrote:
>
>  484 files changed, 31831 insertions(+), 37139 deletions(-)

Please use "git diff -M --stat --summary" to generate the diffstat: the -M 
enables rename detection, and the summary enables a summary of new/deleted 
or renamed files.

With rename detection, the statistics are rather different:

 419 files changed, 13022 insertions(+), 18878 deletions(-)

because git will notice that a fair number of the changes are renames.

			Linus
