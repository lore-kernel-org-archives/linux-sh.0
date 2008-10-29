From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Wed, 29 Oct 2008 04:45:43 +0000
Subject: Re: [PATCH] sh: Add '-up' to ISA flag if enable SH3
Message-Id: <4907EA77.3090904@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4907E73E.9050905@renesas.com>
In-Reply-To: <4907E73E.9050905@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Nobuhiro Iwamatsu wrote:
> By commit of b2d86a3fd9855380598c0c039e712a20086e119f, compilation of SH3 fails.
> In current binutils, "pref" opcode is not support SH3. However, it is supported.
> Please validate this flag till fix binutils.

Sorry, this comment is a mistake.
I wanted to write
 In current binutils, "pref" and other opcode are processed to SH3 as not supported.

Best regards,
 Nobuhiro

