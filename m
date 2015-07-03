From: Rob Herring <robherring2@gmail.com>
Date: Fri, 03 Jul 2015 04:43:30 +0000
Subject: Re: [RFC 1/3] of: make of_mutex public
Message-Id: <CAL_Jsq+-Tx=hwj9ScXBXeGxNwHhq-Lpe-5Kzd-Tu_SNue2aWTA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
 <1435700651-3543-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1435700651-3543-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

+Pantelis

On Tue, Jun 30, 2015 at 4:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> If we want to use OF_DYNAMIC features outside the of framework, we need
> to access this lock. If OF maintainers don't like exporting, we can
> maybe create accessor functions that we can use?

It looks like you are just taking the mutex around various
of_changeset_* calls. We should either split the mutex into of_mutex
for core and changesets and an overlay mutex for overlays, or we need
to do the typical pattern of having changeset functions having locked
and unlocked versions for external and internal (overlays) use.

Rob

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/of/of_private.h | 1 -
>  include/linux/of.h      | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 8e882e706cd8c6..f92ec41efb5dfd 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -31,7 +31,6 @@ struct alias_prop {
>         char stem[0];
>  };
>
> -extern struct mutex of_mutex;
>  extern struct list_head aliases_lookup;
>  extern struct kset *of_kset;
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index b871ff9d81d720..f0464efcbdc5aa 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -32,6 +32,8 @@
>  typedef u32 phandle;
>  typedef u32 ihandle;
>
> +extern struct mutex of_mutex;
> +
>  struct property {
>         char    *name;
>         int     length;
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
