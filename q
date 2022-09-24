
# 永远跟党走，心中有党，事业理想。
# ⣿⣿⣿⣿⣿⠟⠋⠄⠄⠄⠄⠄⠄⠄⢁⠈⢻⢿⣿⣿⣿⣿⣿⣿⣿
# ⣿⣿⣿⣿⣿⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⡀⠭⢿⣿⣿⣿⣿
# ⣿⣿⣿⣿⡟⠄⢀⣾⣿⣿⣿⣷⣶⣿⣷⣶⣶⡆⠄⠄⠄⣿⣿⣿⣿
# ⣿⣿⣿⣿⡇⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠄⠄⢸⣿⣿⣿⣿
# ⣿⣿⣿⣿⣇⣼⣿⣿⠿⠶⠙⣿⡟⠡⣴⣿⣽⣿⣧⠄⢸⣿⣿⣿⣿
# ⣿⣿⣿⣿⣿⣾⣿⣿⣟⣭⣾⣿⣷⣶⣶⣴⣶⣿⣿⢄⣿⣿⣿⣿⣿
# ⣿⣿⣿⣿⣿⣿⣿⣿⡟⣩⣿⣿⣿⡏⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
# ⣿⣿⣿⣿⣿⣿⣹⡋⠘⠷⣦⣀⣠⡶⠁⠈⠁⠄⣿⣿⣿⣿⣿⣿⣿
# ⣿⣿⣿⣿⣿⣿⣍⠃⣴⣶⡔⠒⠄⣠⢀⠄⠄⠄⡨⣿⣿⣿⣿⣿⣿
# ⣿⣿⣿⣿⣿⣿⣿⣦⡘⠿⣷⣿⠿⠟⠃⠄⠄⣠⡇⠈⠻⣿⣿⣿⣿
# ⣿⣿⣿⣿⡿⠟⠋⢁⣷⣠⠄⠄⠄⠄⣀⣠⣾⡟⠄⠄⠄⠄⠉⠙⠻
# ⡿⠟⠋⠁⠄⠄⠄⢸⣿⣿⡯⢓⣴⣾⣿⣿⡟⠄⠄⠄⠄⠄⠄⠄


# 版本:v1.1.7_220912.Full





import requests
import time
import smtplib

def save(Name :str, xml, cookies: str, headers={}, type_='webpy') -> object:
    """
    保存作品
    :param name: 作品名
    :param xml: 作品内容
    :param cookie: COOKIE
    :param headers: 自定义请求头
    :param type_: 作品类型 scratch python cpp
    :return: 返回请求变量
    """
    if headers == {}:
        headers = {'Cookie': cookies,
                   'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33"
                   }

    base = "https://code.xueersi.com/api/compilers/save"
    data = {"name": Name, "xml": xml, "type": type_, "lang": type_, "id": '',
            "original_id": 3, "version": "webpy", "args": [], "planid": 'null', "problemid": '', "projectid": 3,
            "code_complete": 1, "removed": 0, "user_id": 8510061,
            "assets": {"assets": [], "cdns": ["https://livefile.xesimg.com"], "hide_filelist": False}}
    res = requests.post(base, data=data, headers=headers)
    return res


def publish(res, cookies: str, headers: dict = {},description='', name='NONE',tags='') -> object:
    """
    发布作品
    :param res: 请求变量
    :param name: 作品名
    description 作品描述
    不推荐使用（可能出现严重错误）：tags 作品标签
    :return: 请求变量
    """
    if headers == {}:
        headers = {'Cookie': cookies,
                   'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33"
                   }

    res = eval(res.replace('true', "True").replace('false', "False"))
    ID = res['data']['id']
    # print(ID)
    base = "https://code.xueersi.com/api/python/%s/publish"  # 作品id
    data = {"projectId": str(ID), "name": name, "description": description, "created_source": "original",
            "hidden_code": 2, "thumbnail": "https://static0.xesimg.com/talcode/assets/py/default-python-thumbnail.png",
            "tags": tags}
    res = requests.post(base % ID, headers=headers, data=data)
    return res

def raw_publish(ID, cookies: str, headers: dict = {},thumbnail="https://static0.xesimg.com/talcode/assets/py/default-python-thumbnail.png",description='', name='NONE',tags='') -> object:
    """
    发布作品（推荐使用）
    :param ID:作品ID 该ID必须属于自己
    :param name: 作品名
    :param description 作品描述
    :param thumbnail 封面图片
    不推荐使用（可能出现严重错误）：tags 作品标签
    :return: 请求变量
    """
    if headers == {}:
        headers = {'Cookie': cookies,
                   'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33"
                   }


    # print(ID)
    base = "https://code.xueersi.com/api/python/%s/publish"  # 作品id
    data = {"projectId": str(ID), "name": name, "description": description, "created_source": "original",
            "hidden_code": 2, "thumbnail": thumbnail,
            "tags": tags}
    res = requests.post(base % ID, headers=headers, data=data)
    return res


def cancel_publish(ID, cookies):
    "https://code.xueersi.com/api/python/34747602/cancel_publish"
    data = {'params': {'id': ID}}
    headers = {'Cookie': cookies,
               'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33",'cookie':cookies
               }
    res = requests.post("https://code.xueersi.com/api/python/34747602/cancel_publish", data=data, headers=headers)
    return res


def report(Cookie: str, Reason: str, reason_detail: int, complaint_reason_url: str, id_: int) -> object:
    """
    举报作品
    :param cookie:COOKIE
    :param reason: 理由
    :param reason_detail: 理由类型 1 2 3等
    :param complaint_reason_url: （被抄袭）源地址
    :param id_: 作品ID
    :return: 请求变量
    """
    base = "https://code.xueersi.com/api/projects/submit_complaint"
    data = {"reason": Reason, "reason_detail": reason_detail, "complaint_reason_images": [],
            "complaint_reason_url": complaint_reason_url, "id": id_}

    res = requests.post(base, headers={
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33',
        'Cookie': Cookie},
                        data=data)
    return res


def send_comment(Content: str, Type: int, Cookie: str, Id_: int, UserAgent='', headers={}) -> object:
    """
    发送评论

    type_:
    1:Python（包含webpy等）
    2:Cpp
    3:Scratch
    # 严重警告： 如果不填写会导致发送失败！

    :param Content: 内容
    :param Cookie: COOKIE
    :param Id_: 作品id
    :param Type_: 作品类型
    :param UserAgent: 用户代理（可不填，有默认UA）
    :param headers: 请求头（可不填，会默认设置）
    :return: 访问变量
    """

    if UserAgent == '':
        UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.30"

    if headers == {}:
        headers = {'Cookie': Cookie,
                   'User-Agent': UserAgent
                   }

    if Type == 1:
        Type = 'CP_'
    elif Type == 2:
        Type = 'CC_'
    elif Type == 3:
        Type = 'CS_'
    else:
        raise ValueError('变量Type 包含意外的值:%s 应为1、2或3' % Type)

    res = requests.post("https://code.xueersi.com/api/comments/submit",
                        headers=headers,
                        data={"appid": 1001108, 'topic_id': Type + str(Id_), 'target_id': '0', 'content': Content})
    return res


def get_works_info(ID: int) -> dict:
    """
    获取作品信息
    :param ID: 作品ID
    :return: dict
    """
    base = "https://code.xueersi.com/api/compilers/v2/%s" % ID
    res = requests.get(base, headers={
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33'})
    f = eval(res.text.replace('null', '\'null\'').replace('true', '\'true\'').replace('false', '\'false\''))
    return f


def check_work_exists(ID) -> bool:
    """
    检查作品是否存在
    :param ID:作品ID
    :return: 作品是否存在（bool）是（True）否（False）
    """
    f = get_works_info(ID)
    print(f)
    if 'status_code' in f:
        return False
    else:
        if f['data']['published_at'] != '0000-00-00 00:00:00':
            return True
        else:
            return False


def check_work_exists_mode2(ID) -> bool:
    """
    检查作品是否存在
    :param ID:作品ID
    :return: 作品是否存在（bool）是（True）否（False）
    """
    f = get_works_info(ID)
    # print(f)
    if 'status_code' in f:
        return False
    else:
        return True


def process_works_info(Dict: dict) -> dict:
    """
    解析作品常用信息

    name: 作品名
    type: 类型（homework或normal等）
    description: 通常为简介，也有可能显示在xml项
    xml: 可能为简介
    user_id: 作者ID
    thumbnail: 封面链接
    modified_at: 最后一次修改日期
    likes: 点赞
    views: 浏览、观看数
    comments: 评论数
    deleted_at: 删除时间（通常为空）
    created_at: 创建时间
    updated_at: 提交时间
    topic_id: 待研究
    manual_weight: 是否适合继续推荐（存疑，变量名显示可能是管理员手动设置）
    popular_score: 受喜爱指数 0-1之间 越高代表越受欢迎

    :param Dict: get_info的返回值（或其他可分析的字典）
    :return:


    """
    if 'status_code' in Dict:  # 失败
        return {'stat': '0', 'msg': Dict['msg']}

    _output = {
        "name": Dict['data']['name'],
        'type': Dict['data']['type'],
        'description': Dict['data']['description'],
        'xml': Dict['data']['xml'],
        'user_id': Dict['data']['user_id'],
        'thumbnail': Dict['data']['thumbnail'],
        'modified_at': Dict['data']['modified_at'],
        'likes': Dict['data']['likes'],
        'views': Dict['data']['views'],
        'comments': Dict['data']['comments'],
        'deleted_at': Dict['data']['deleted_at'],
        'created_at': Dict['data']['created_at'],
        'updated_at': Dict['data']['updated_at'],
        'topic_id': Dict['data']['topic_id'],
        'manual_weight': Dict['data']['manual_weight'],
        'popular_score': Dict['data']['popular_score']
    }
    return _output


def get_user_info(user_id, cookie='') -> dict:
    """
    获取用户信息

    已知信息：
    fans 粉丝
    follows 关注
    is_my 是我自己
    realname 真名
    signature 个性签名

    协议：GET
    :param user_id 用户id
    :return:
    """
    headers = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33','cookie':cookie
    }
    if cookie != '':
        _output = requests.get('https://code.xueersi.com/api/space/profile?user_id=%s' % user_id, headers=headers)
    else:
        _output = requests.get('https://code.xueersi.com/api/space/profile?user_id=%s' % user_id, headers=headers)
    _output = eval(_output.text.replace('true', 'True').replace('false', 'False'))
    return _output


def get_user_page_info(user_id) -> dict:
    """
    首页信息
    https://code.xueersi.com/api/space/index?user_id=?

    已知信息：（data下）
    overview 我的成就
    fans 粉丝列表
    favorites 收藏列表
    follows 关注列表
    representative_work 代表作信息
    works 作品列表

    协议 GET
    :param user_id: 用户id
    :return: 输出以上
    """
    _output = requests.get('https://code.xueersi.com/api/space/index?user_id=%s' % user_id)
    _output = eval(_output.text.replace('true', 'True').replace('false', 'False'))
    return _output


def get_msg_overview(cookie: str, headers={}) -> dict:
    """
    获取用户消息提示（必须登录）
    :param cookie: COOKIE
    :return: 返回值

    示例返回值：
    {"stat":1,"status":1,"msg":"\u64cd\u4f5c\u6210\u529f","data":[{"category":1,"text":"\u8bc4\u8bba\u548c\u56de\u590d","count":0},{"category":2,"text":"\u70b9\u8d5e\u4e0e\u6536\u85cf","count":0},{"category":5,"text":"\u5173\u6ce8","count":0},{"category":3,"text":"\u53cd\u9988\u548c\u5ba1\u6838","count":0},{"category":4,"text":"\u7cfb\u7edf\u6d88\u606f","count":0}]}
    category 1 评论与回复
    category 2 点赞与收藏
    category 5 关注
    category 3 反馈和审核
    category 4系统消息

    count为消息数量

    """
    base = "https://code.xueersi.com/api/messages/overview"
    if headers == {}:
        headers = {
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33',
            'cookie':cookie
        }
    res = requests.get(base, headers=headers)
    res = eval(res.text)
    return res


def get_comments(ID) -> dict:
    """
    获取评论信息
    :return:
    """
    headers = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33'
    }
    base = "https://code.xueersi.com/api/comments?appid=1001108&topic_id=%s&parent_id=0&order_type=&page=1&per_page=15"
    topic_id = process_works_info(get_works_info(ID))['topic_id']
    res = requests.get(base % topic_id, headers=headers)
    res = res.text.replace('null', '\'null\'').replace('false', 'False').replace('true', 'True')
    return eval(res)


def process_comments(Dict: dict, mode=1):
    """
    获取评论信息
    :param res:get_comments的返回值或其他可处理内容
    :param mode:模式
    :return:

    page:页数
    per_page: 未知，直译"每页"
    total: 评论总数
    ------------------------
    mode
    1 不对任何信息进行处理，仅获取常用信息
    2 仅输出所有评论的信息（包含评论内容）
    3 仅输出所有评论文本
    ------------------------


    can_delete: 是否可以删除 bool
    can_top: 是否为置顶 bool
    comment_from: 评论来源（待分析） str
    content: 评论文本 str
    created_at: 发送时间 str
    emojis: 使用的emoji列表 list
    id: 可能是评论的ID，待分析 int
    is_like: 已登录用户是否点赞 bool
    is_topic_author_like: 作者是否点赞 bool
    is_topic_author_reply: 作者是否回复过 bool
    is_unlike: 已登录用户是否踩过 bool
    likes: 点赞数 int
    links: 评论发布者发送的链接 list
    parent_id: 未知，待分析 int
    removed: 未知，待分析 int
    replies: 回复数量 int
    reply_list: 回复列表 list
    data: 未知，待分析 list
    hasMore: 未知，待分析 bool
    total: 未知，待分析 int
    reply_user_id: 回复作品作者id str
    reply_username: 回复作品作者名
    target_id: 待分析 int
    top: 是否为置顶（是为1 否为0） int
    topic_id: 作品的topicid str
    unlikes: 踩过人数
    user_avatar_path: 评论发布者头像地址 str
    user_id: 发布者uid str

    """

    if mode not in [1, 2, 3]:
        raise ValueError('意外的值:%s' % mode)

    def mode_1(Dict):
        _output = {
            'page': Dict['data']['page'],  # 页数
            'per_page': Dict['data']['per_page'],  # 未知
            'total': Dict['data']['total'],  # 评论总数
            'comments': Dict['data']['data']

        }
        return _output

    def mode_2(Dict):
        return Dict['data']['data']

    def mode_3(Dict):
        _output = []
        for i in Dict['data']['data']:
            _output.append(i['content'])
        return _output

    return eval('mode_%s(Dict)' % mode)


def delete_comment(comment_id: int, ID: int, cookie: str) -> dict:
    """
    删除评论
    :param comment_id: 评论id（在get_comments中获得）
    :param ID: 作品id
    :param cookie: cookie
    :return:
    """
    headers = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33',
        'Cookie':cookie
    }
    data = {
        'appid': 1001108,
        'topic_id': process(get_info(ID)),
        'id': comment_id
    }
    res = requests.post("https://code.xueersi.com/api/comments/delete", headers=headers, data=data)
    return eval(res.text)


def follow(follow_user_id: int, cookies: str) -> dict:
    """

    :param follow_user_id:
    :param cookies:
    :return:
    """
    data = {'followed_user_id': str(follow_user_id), 'state': 1}
    headers = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33',
        'Cookie':cookies
    }
    res = requests.post('https://code.xueersi.com/api/space/follow', data=data, headers=headers)
    return eval(res.text)


def like(cookies: str, ID: int):
    "https://code.xueersi.com/api/python/34748790/like"
    data = {'params': {'id': ID, 'lang': 'code', 'form': get_works_info(ID)['data']['lang']}}
    headers = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33',
        'Cookie':cookies
    }
    res = requests.post("https://code.xueersi.com/api/python/%s/like" % ID, headers=headers, data=data)
    return res


def unlike(cookies: str, ID: int):
    "https://code.xueersi.com/api/python/34748790/unlike"
    data = {'params': {'id': ID, 'lang': 'code', 'form': get_works_info(ID)['data']['lang']}}
    headers = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33',
        'Cookie':cookies
    }
    res = requests.post("https://code.xueersi.com/api/python/%s/unlike" % ID, headers=headers,
                        data=data)
    return res


def edit_signature(cookies: str, word: str):
    """
    更改个性签名
    cookies:用户登录凭证
    word:目标内容

    return 请求变量
    """
    path = "https://code.xueersi.com/api/space/edit_signature"
    data = {"signature": word}
    headers = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 Edg/102.0.1245.33',
        'Cookie':cookies
    }
    res = requests.post(path, data=data, headers=headers)
    return res
c="xesId=ded317cc05ea8fa6e0b0be68a57c78db; xes-code-id=54a661900e486d95a8cc386becffb438.73698c629e555d6f325ea193d1b79e5f; wx=df4a533afbe708d14d9724e5874f63d79qmffsxb9m; xes_rfh=EDp4y4nnpb7BvLmPx8A64-_Q5u6-e8L_uZvdk7bbCRh9uIrl_B8vcdcfFXyblOzbCW7SQk3Zwnb1wU8mVYlme7skg2hlKHBAxDscLaeMj9YTq3l1nZXDxeFKlWl1bh43H96owTH-Vej7yLR0aHam95_UlulfxeLXq4j0xum_ZjI.cv1; is_login=1; stu_id=73048330; stu_name=73048330; userGrade=3; xes_acc=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1aWQiOiI3MzA1MjgyNSIsInVzZXJfaWQiOiI3MzA0ODMzMCIsInJvbGUiOjEsImV4cCI6MTY2Mjg5MTU1MSwidmVyIjoiMS4wIn0.mFGz5Zd9q96c3FZgirAtMgus1jTusrDqZrLrU6raTHtm3yJuWuuL5AFOrleIwQBA1IAimp9o-rI2tmL0ELu5PDSGrwii91k5qCBTsAqLWITzzYRpRwj_aj5FtWCIJ64jjSBN-anxe5k_aTdOP0naz7_hm4gdrkl_YJSpCXfgwQg5ro73DKVJFP0gDzI4qYYoRVGoLsAXMnWiwBZBnsjz89KRCy0P_FnE5A1aDyzxfdcjTvhuGb_OCgaKpEU_XT8kCLfGp6APRXoZ-XhFFzUOwm-5URVKrmlcKwhjTHAtd6KMsGwl_tqr7RgS4-F0nOidMXtMFP_wKbMqSr5rLJSRIg; xes_encrypt_uid=QFUYH3L; Hm_lvt_a8a78faf5b3e92f32fe42a94751a74f1=1663762009,1663842010,1663933301,1663945301; user-select=python; tal_token=tal173GjdFSq2erL0-mqIrVi7g7SEa22jKcF5Br1IV57JLc2_barl4qkOQ6tkZpVmF8BoV79LJhFy2klsQVQreIx3aewjB0baJm0CMZgwMyQSogLyqLwwojOGr8FjEpvSpOM1-4kBs8KTtFyWZqdt5oQZbiBDt9lPhLktCRsPdi0Cr8N8ea4RHOheqKZki0iBDuMLNfAzdCAPsDI35-9VK4ZimN7davwQCmnyO10sca8vQaJP6SkACBkgcEg-uJEyy2EsBhKyP8sLzhgXG8-oY8SdKShAN_eWkYga_fRFsBOduLUmDI; Hm_lpvt_a8a78faf5b3e92f32fe42a94751a74f1=1663951577; xes_run_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIuY29kZS54dWVlcnNpLmNvbSIsImF1ZCI6Ii5jb2RlLnh1ZWVyc2kuY29tIiwiaWF0IjoxNjYzOTUxNTc3LCJuYmYiOjE2NjM5NTE1NzcsImV4cCI6MTY2Mzk2NTk3NywidXNlcl9pZCI6IjczMDQ4MzMwIiwidWEiOiJNb3ppbGxhXC81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXRcLzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZVwvMTA1LjAuMC4wIFNhZmFyaVwvNTM3LjM2IiwiaXAiOiIyNy4zOC4xMTIuMjI3In0.ZwydUpy_mLO870A7JhGyx6NS1Jwwhid-bPp_iyXEG_Y; prelogid=ae18d75a31ca2787ca6bad3e3e9d643b; X-Request-Id=54fcc3087dd390d68529aa9a8335b482"
#                       37130358

import email
import time,random
import smtplib
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart
from email.header import Header
def send(r,text,title):

    # password:TYBYJRJWLICNLWAH
    try:
        mailserver = 'smtp.yeah.net'
        port = 25
        sender = 'qazqwewsx1@yeah.net'
        passwd = 'TYBYJRJWLICNLWAH'  # JRFGJKVWRISMGCLA
        server = smtplib.SMTP(mailserver, port)  # 发件人邮箱中的SMTP服务器，端口是25
        server.login(sender, passwd)  # 发件人邮箱账号、邮箱授权码
        receive = r
        text_info = text
        msg = MIMEText(text_info, 'plain', 'utf-8')
        msg['From'] = sender
        msg['To'] = receive
        msg['Subject'] = title  # 标题
        server.sendmail(sender, receive, msg.as_string())
        return True
    except Exception as error:
        print(error)
        return False
sst=time.time()
counter=0
# send('1424393706@qq.com','START!!!','START!!!')
import random
while True:
    if check_work_exists_mode2(37999999):
        send('1424393706@qq.com', 'SUCCESS! Time:%s' % (time.time() - sst), 'SUCCESS')
        save('38000000', '1', c)
        raise Exception('F')
    time.sleep(0.5)
