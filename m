From: yoshii.takashi@gmail.com
Date: Thu, 10 Dec 2009 08:48:12 +0000
Subject: Re: [PATCH] sh: Add CONFIG_PARAM_* to set boot parameters.
Message-Id: <20091210174812.393a51aa.yoshii.takashi@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
In-Reply-To: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul, I have forgotten to ask this.

> Name: CMDLINE
> Address/size: empty_zero_page+0x100/char[256]
> Type: loader to kernel information
> 
>  kernel may read this as a command line depending on its configuration.
>  Boot loader should put '\0' if no options.

This time, I changed the size to 256.
First I thought that
- This field is char[512].
- Valid size depends on the configuration, because the kernel
  reads (512 - N) byte when it has N byte of default command line.

But, after browsing log around CMDLINE, I think now I know what you wanted to do.
Your design is
- This field is char[256]
- All of them are guaranteed to be read (except OVERWRITE mode),
  because default command line is also char[256], and buffer is char[512].

Right?

/yoshii
