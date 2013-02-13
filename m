From: phil.edworthy@renesas.com
Date: Wed, 13 Feb 2013 12:21:42 +0000
Subject: Re: [PATCH RFC] sh: pfc: Add ability to use separate read & write GPIO data regs
Message-Id: <OFC451CA33.A7930984-ON80257B11.003D489D-80257B11.0043E811@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360335771-4468-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1360335771-4468-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

> On Fri, Feb 08, 2013 at 03:02:51PM +0000, Phil Edworthy wrote:
> > On several devices, there are separate registers for data input
> > and data output.
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Can you provide a bit more information out how these actually look? As
> you are reusing the reg_width it seems the write register must be
> relatively close to the read register for these parts, in which case you
> could simply increase the size of the mapping and provide a write offset
> (which would be 0 for parts where read_reg = write_reg).

Sure, for r8a7779 the data write reg (OUTDTx) is at an offset of -8 from 
the data read reg (INDTx). I had thought about just using an offset, but 
thought it would be better to have two mappings rather than the code to 
handle negative offsets. I assumed that other devices might have a 
positive offset to OUTDTx.
 
> > +#define PINMUX_DATA_REG2(name, r, r2, r_width) \
> > +   .reg = r, .wreg = r2, .reg_width = r_width,   \
> >     .enum_ids = (pinmux_enum_t [r_width]) \
> > 
> As imaginative as r2 and reg2 are, how about something at least
> masquerading as informative? PINMUX_DATA_RWREG() or something perhaps?
Yeah, I was suffering from a complete lack of imagination at the time! 
Would this be better?

#define PINMUX_DATA_RWREG(name, read_reg, write_reg, r_width) \
   .reg = read_reg, .wreg = write_reg, .reg_width = r_width,   \
   .enum_ids = (pinmux_enum_t [r_width]) \

Thanks
Phil
