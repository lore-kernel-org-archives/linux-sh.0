From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Date: Sat, 11 Apr 2009 22:31:28 +0000
Subject: Re: [RFC][patch] VMUFAT filesystem - v2
Message-Id: <20090411223128.GO13936@josefsipek.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1239487891.6523.17.camel@localhost.localdomain>
In-Reply-To: <1239487891.6523.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, viro <viro@zeniv.linux.org.uk>, linux-sh <linux-sh@vger.kernel.org>

On Sat, Apr 11, 2009 at 11:11:31PM +0100, Adrian McMenamin wrote:
...
> diff --git a/fs/vmufat/inode.c b/fs/vmufat/inode.c
> new file mode 100644
> index 0000000..8ac0cba
> --- /dev/null
> +++ b/fs/vmufat/inode.c
...
> +#define VMUFAT_MAGIC 0x55555555

Last time I had a magic number lying around like that, I've been told to put
it in include/linux/magic.h.

...
> +struct memcard {
...
> +};
> +
> +struct vmufat_block_list {
...
> +};

Is this the code in a single file? Uf.

> +struct vmufat_file_info {
> +	__u8 ftype;
> +	__u8 copy_pro;
> +	__u16 fblk;
> +	char fname[12];

You had a #define for file name length near the top of the file. Why not use
it? :)

> +static inline int vmufat_index(int fno)
> +{
> +	return (fno % 0x10) * 0x20;
> +}
> +
> +static inline int vmufat_index_16(int fno)
> +{
> +	return (fno % 0x10) * 0x10;
> +}

I'd change the % and * to bit mask & shift.

Ok, I need to run out. I haven't seen the rest of the (rather long) patch.

Josef 'Jeff' Sipek.

-- 
Intellectuals solve problems; geniuses prevent them
		- Albert Einstein
