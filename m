From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 May 2009 09:23:37 +0000
Subject: Re: qemu-sh repository does not apply
Message-Id: <20090527092337.GA12867@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Feb 01, 2009 at 04:57:15PM +0900, Shin-ichiro KAWASAKI wrote:
> Current qemu svn head and qemu-sh staging repository do not fit together,
> because of the progress of qemu development.  'quilt push -a' command
> stops with patch failure.  I think this defect should be fixed for
> qemu-sh users.
> 
I let this lapse since things were being merged pretty quickly, but it
looks like things are piling up again. I've refreshed the series with the
current outstanding patches.
