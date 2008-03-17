From: Stuart MENEFY <stuart.menefy@st.com>
Date: Mon, 17 Mar 2008 19:51:35 +0000
Subject: Re: [PATCH] Use relative path when creating include/asm/{mach,cpu}
Message-Id: <47DECBC7.8070802@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <47DEC594.6010502@gmail.com>
In-Reply-To: <47DEC594.6010502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Franck Bui-Huu wrote:
> From: Franck Bui-Huu <fbuihuu@gmail.com>
> 
> Usually relative paths are preferred because they survive directory
> moves, work across networked file systems/chrooted environments.
> 
> And in this case, there's no point to use absolute paths.

I've not had a chance to check this, but are you sure this will work
when building with O= (aka KBUILD_OUTPUT) set?

Stuart
