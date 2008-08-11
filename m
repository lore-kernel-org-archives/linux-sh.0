From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 Aug 2008 11:28:59 +0000
Subject: Re: [PATCH] input: migor_ts compile and detection fix
Message-Id: <20080811112858.GA5340@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080811055349.19913.70612.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080811055349.19913.70612.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org

On Mon, Aug 11, 2008 at 02:53:49PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> The i2c layer got changed while the migor_ts driver was in the input
> tree waiting to get merged upstream. Fix current compile issue by using
> struct i2c_client member "name" instead of "driver_name". Also, add
> id_table to make sure the device gets properly detected.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Paul, can you pick up this one together with other SuperH fixes?
> 
Yes, I rolled it in to my queue, thanks.
