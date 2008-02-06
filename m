From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Feb 2008 09:57:02 +0000
Subject: Re: Renesas offers new SH7721 kernel
Message-Id: <20080206095702.GA10471@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <9b3c8e40802060025q106179bfmf5b3ea391a0c697c@mail.gmail.com>
In-Reply-To: <9b3c8e40802060025q106179bfmf5b3ea391a0c697c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 06, 2008 at 09:25:46AM +0100, Mark Jonas wrote:
> I read (http://eu.renesas.com/fmwk.jsp?cnt=press_release01feb2008.htm&fp=/company_info/news_and_events/press_releases)
> that Renesas offers a new (2.6.22.11) kernel for the SH7721 that
> support USB host, USB function and the LCD controller
> (http://www.superh-linux.org/platforms/index.html). According to what
> I saw on this mailing list so far there have been no complete patches
> to make the mentioned features really work. Am I wrong?
> 
Correct. No one has done the necessary leg work for getting the patches
submitted or cleaned up, so they will not appear in the upstream kernel
until that happens.
