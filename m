From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 31 Oct 2008 07:09:18 +0000
Subject: Re: [PATCH] sh: Add '-up' to ISA flag if enable SH3
Message-Id: <20081031070918.GD26928@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4907E73E.9050905@renesas.com>
In-Reply-To: <4907E73E.9050905@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 29, 2008 at 01:45:43PM +0900, Nobuhiro Iwamatsu wrote:
> Nobuhiro Iwamatsu wrote:
> > By commit of b2d86a3fd9855380598c0c039e712a20086e119f, compilation of SH3 fails.
> > In current binutils, "pref" opcode is not support SH3. However, it is supported.
> > Please validate this flag till fix binutils.
> 
> Sorry, this comment is a mistake.
> I wanted to write
>  In current binutils, "pref" and other opcode are processed to SH3 as not supported.
> 

[ random cursing at binutils goes here ]

Yes, you are correct, the -up is necessary. I've re-added it for all
non-SHmedia parts.
