From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 Feb 2013 15:23:37 +0000
Subject: Re: [PATCH RFC] sh: pfc: Add ability to use separate read & write GPIO data regs
Message-Id: <20130211152336.GA6088@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1360335771-4468-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1360335771-4468-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 08, 2013 at 03:02:51PM +0000, Phil Edworthy wrote:
> On several devices, there are separate registers for data input
> and data output.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Can you provide a bit more information out how these actually look? As
you are reusing the reg_width it seems the write register must be
relatively close to the read register for these parts, in which case you
could simply increase the size of the mapping and provide a write offset
(which would be 0 for parts where read_reg = write_reg).

> +#define PINMUX_DATA_REG2(name, r, r2, r_width) \
> +	.reg = r, .wreg = r2, .reg_width = r_width,	\
>  	.enum_ids = (pinmux_enum_t [r_width]) \
>  
As imaginative as r2 and reg2 are, how about something at least
masquerading as informative? PINMUX_DATA_RWREG() or something perhaps?
