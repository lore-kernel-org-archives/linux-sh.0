From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 Aug 2008 15:16:48 +0000
Subject: Re: [PATCH] sh: remove MSTPCR defines from Migo-R header file
Message-Id: <20080811151648.GA5723@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080811055246.19910.85965.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080811055246.19910.85965.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 11, 2008 at 02:52:46PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Remove MSTPCR register definitions from Migo-R header file. The clock
> frame work should be used instead of direct register access. 
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

applied the series, thanks.
