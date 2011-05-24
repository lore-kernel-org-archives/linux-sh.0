From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 May 2011 07:22:06 +0000
Subject: Re: [PATCH 0/3] MERAM support for LCDC (clocks and platform data)
Message-Id: <20110524072206.GE11986@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1306220482-29107-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1306220482-29107-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 24, 2011 at 04:01:19PM +0900, Damian Hobson-Garcia wrote:
> This patch series adds the necessary platform data for the LCDC MERAM 
> support.
> 
> This patch series is based on the common/fbdev-meram branch
> 
> The fisrt patch "sh_mobile: Add MSTP clock for MERAM" is being resubmitted
> as it is currently not in the the common/fbdev-meram branch. 
> 
This patch is in the rmobile-latest branch, as it's conceptually
isolated. I'll take the platform patches through there, and drivers/video
changes through the common/fbdev{,-meram} branches. Linus tends to get
rather grumpy when things are muddled together otherwise.
