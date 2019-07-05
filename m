From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Fri, 05 Jul 2019 03:43:38 +0000
Subject: Re: [PATCH 18/39] docs: admin-guide: add kdump documentation into it
Message-Id: <6911b74c-848f-0060-3db5-b5d7e8061cb5@linux.alibaba.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <654e7591c044632c06257e0f069a52c0bb993554.1561724493.git.mchehab+samsung@kernel.org>
In-Reply-To: <654e7591c044632c06257e0f069a52c0bb993554.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Jerry Hoemann <jerry.hoemann@hpe.com>, Harry Wei <harryxiyou@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Young <dyoung@redhat.com>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org



在 2019/6/28 下午8:30, Mauro Carvalho Chehab 写道:
> The Kdump documentation describes procedures with admins use
> in order to solve issues on their systems.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/admin-guide/bug-hunting.rst            | 4 ++--
>  Documentation/admin-guide/index.rst                  | 1 +
>  Documentation/{ => admin-guide}/kdump/gdbmacros.txt  | 0
>  Documentation/{ => admin-guide}/kdump/index.rst      | 1 -
>  Documentation/{ => admin-guide}/kdump/kdump.rst      | 0
>  Documentation/{ => admin-guide}/kdump/vmcoreinfo.rst | 0

I am not sure if it's convenience for people to have more levels in docs.

But I guess, move archs into a Documentation/arch/ dir should be fine. like Documentation/arch/{x86,arm,arm64,ia64,m68k,s390,powerpc,...}

Thanks
Alex
