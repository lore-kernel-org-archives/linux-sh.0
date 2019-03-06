From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 06 Mar 2019 18:03:15 +0000
Subject: Re: Kernel compilation for SH4 arch fails with poky 2.5.2
Message-Id: <538ed3f5-a40c-6286-8cd8-d7be6fdfbb31@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <8beaba914a6a423ba3acef4adfd34179@BLRX13MDC425.AMER.DELL.COM>
In-Reply-To: <8beaba914a6a423ba3acef4adfd34179@BLRX13MDC425.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Raveendra!

Apologies for my late reply, I have been traveling.

On 3/5/19 11:06 PM, Raveendra.Reddy.P@dell.com wrote:
>> If you give me the kernel configuration, I could try it with gcc-8 and report back.
> We are able to compile successfully after removing/disabling "CONFIG_DEBUG_INFO" from our config file. Generally this is used for GDB debugging purpose.
> Does this removal will cause any side-effects. Please share your thoughts.

Since GDB is currently not supporting the Linux/SH target (I do have
an out-of-tree patchset on my github [1]), I think you are not losing
if you disable CONFIG_DEBUG_INFO.

Adrian

> [1] https://github.com/glaubitz/binutils-gdb/tree/linux-sh

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
