From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 03 Dec 2009 21:12:00 +0000
Subject: Re: [PATCH] sh: fix build with FPU disabled
Message-Id: <20091203211159.GE11047@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091203122041.9836.36225.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091203122041.9836.36225.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 03, 2009 at 09:20:41PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch makes sure platforms lacking FPU build
> Without this sh7722 fails to build.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

This was fixed 8 days ago.
