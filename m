From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Feb 2013 03:34:19 +0000
Subject: Re: [PATCH] ARM: shmobile: Make EMEV2 setup functions static
Message-Id: <20130214033418.GS15879@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130213134947.12392.92386.sendpatchset@w520>
In-Reply-To: <20130213134947.12392.92386.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 13, 2013 at 10:49:47PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Adjust emev2_init_delay() and emev2_add_standard_devices_dt()
> to become static. They are not used outside this file anyway.

I have applied the entire series to the soc5 branch thus queued up
for v3.10. It is also in the next branch and thus should appear
in linux-next in the not to distant future.
