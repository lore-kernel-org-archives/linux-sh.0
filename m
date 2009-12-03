From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Dec 2009 14:22:04 +0000
Subject: Re: [PATCH] sh: include empty zero page in zImage
Message-Id: <aec7e5c30912030622l586616b6hddc52133f84b6e52@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091203122619.9975.58412.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091203122619.9975.58412.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Stuart,

On Thu, Dec 3, 2009 at 8:48 AM, Stuart MENEFY <stuart.menefy@st.com> wrote:
> If you do this won't you overwrite any parameters from the boot loader?

True, so we probably want to do this in a different way.

I don't want to break anything of course, but I'm not sure if u-boot
supports passing parameters to zImages. It's not a u-boot centric
world though.

I remember adding command line passing code to kexec-tools for either
vmlinux or zImage, but I doubt that both image types are properly
supported in kexec today.

Any ideas? How are things for ST? I need to fix up romImage somehow at
least. Maybe zImage should be left alone as-is and work should be put
into fixing the boot loaders.

Cheers,

/ magnus
