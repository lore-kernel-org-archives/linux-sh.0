From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 04 Dec 2009 07:24:56 +0000
Subject: Re: [PATCH] sh: include empty zero page in romImage
Message-Id: <aec7e5c30912032324y500e8f4el3d66c9f992f2731c@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091204064235.7674.79539.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091204064235.7674.79539.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, Dec 4, 2009 at 3:42 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@opensource.se>
>
> This patch updates the romImage code to include the
> empty_zero_page contents from vmlinux. Without this
> patch the empty zero page is lef uninitialized.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
> =A0Compiles and looks fine through objdump, but not
> =A0runtime tested due to lack of hardware debugger.

Update, runtime tested this using uboot bootp + go on a migor board
and it seems ok!

/ magnus
