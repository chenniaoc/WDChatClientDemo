#ifndef __CS_HEADER_H_SHENJIAN_20110708_0948__
#define __CS_HEADER_H_SHENJIAN_20110708_0948__


#include<stdint.h>

#define CS_HEADER_MAGIC (0x20150130)
#define CS_HEADER_VERSION (0x01)

//是否加密
enum E_SYM_METHOD
{
    SYM_METHOD_NONE = 1, //不加密
    SYM_METHOD_ENC = 2 //加密
};


//连接状态
enum E_CONNECT_STATUS
{
    CONNECT_STATUS_STEP_1 = 1,
    CONNECT_STATUS_OK = 2
};

//CMD
enum E_HEADER_CMD
{
    HEADER_CMD_HANDSHAKE = 1,
    HEADER_CMD_COMMON = 2,
    HEADER_CMD_KEEPALIVE = 3,
    HEADER_CMD_LOGIN = 4,
    HEADER_CMD_LOGOUT = 5,
    HEADER_CMD_KICKOUT = 6,
    HEADER_CMD_QUICK_CONNECT = 7,
    HEADER_CMD_SET_BACKGROUND = 8,
};

struct PROTO_FLAG
{
    uint8_t connect_status; //E_CONNECT_STATUS
    uint8_t sym_method; //E_SYM_METHOD
}__attribute__((packed));

//定长包头
//变长包体
typedef struct cs_header
{
    uint32_t version; //协议版本 CS_HEADER_VERSION
    uint32_t magic_num; //校验标记 CS_HEADER_MAGIC
    uint16_t cmd; //命令号 E_HEADER_CMD
    struct PROTO_FLAG proto_flag; //协议标记 PROTO_FLAG
    uint32_t org_len; //原始长度
    uint32_t enc_len; //加密后长度
    uint32_t reserved1;
    uint32_t reserved2;
    uint8_t data[];
}__attribute__((packed)) TCP_HEADER;

struct s1_data
{
    uint32_t sym_len;
    uint32_t reserved1;
    uint8_t data[];
}__attribute__((packed));


struct s2_data
{
    uint32_t data_len;
    uint32_t reserved;
    uint8_t data[];
}__attribute__((packed));


#define RANDOM_KEY_SEED_LEN (16)
#define MAX_CT_PACKET_SIZE (64*1024)
#define MAX_TC_PACKET_SIZE (256*1024)

#endif

